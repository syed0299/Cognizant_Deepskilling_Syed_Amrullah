CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
    v_count NUMBER := 0;
BEGIN
    FOR rec IN (SELECT AccountID, Balance FROM Accounts WHERE AccountType = 'Savings') LOOP
        UPDATE Accounts
        SET Balance = Balance + (Balance * 0.01)
        WHERE AccountID = rec.AccountID;
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE('Account ' || rec.AccountID || ': Old Balance = ' || rec.Balance || ', New Balance = ' || ROUND(rec.Balance * 1.01, 2));
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Monthly interest applied to ' || v_count || ' savings accounts.');
END;
/

BEGIN
    ProcessMonthlyInterest;
END;
/

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    p_department IN VARCHAR2,
    p_bonus_percentage IN NUMBER
) IS
    v_count NUMBER := 0;
BEGIN
    FOR rec IN (SELECT EmployeeID, Name, Salary FROM Employees WHERE Department = p_department) LOOP
        UPDATE Employees
        SET Salary = Salary + (Salary * p_bonus_percentage / 100)
        WHERE EmployeeID = rec.EmployeeID;
        v_count := v_count + 1;
        DBMS_OUTPUT.PUT_LINE('Employee ' || rec.Name || ': Old Salary = ' || rec.Salary || ', New Salary = ' || ROUND(rec.Salary * (1 + p_bonus_percentage / 100), 2));
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Bonus applied to ' || v_count || ' employees in ' || p_department || ' department.');
END;
/

BEGIN
    UpdateEmployeeBonus('IT', 10);
END;
/

CREATE OR REPLACE PROCEDURE TransferFunds(
    p_from_account IN NUMBER,
    p_to_account IN NUMBER,
    p_amount IN NUMBER
) IS
    v_from_balance NUMBER;
BEGIN
    SELECT Balance INTO v_from_balance
    FROM Accounts
    WHERE AccountID = p_from_account;

    IF v_from_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance in account ' || p_from_account);
    END IF;

    UPDATE Accounts
    SET Balance = Balance - p_amount
    WHERE AccountID = p_from_account;

    UPDATE Accounts
    SET Balance = Balance + p_amount
    WHERE AccountID = p_to_account;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transfer successful: ' || p_amount || ' transferred from Account ' || p_from_account || ' to Account ' || p_to_account);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: One or both account IDs are invalid.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

BEGIN
    TransferFunds(1, 2, 200);
END;
/
