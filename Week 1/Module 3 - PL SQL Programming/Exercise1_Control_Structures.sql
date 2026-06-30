BEGIN
    FOR rec IN (SELECT CustomerID, Name, FLOOR(MONTHS_BETWEEN(SYSDATE, DOB) / 12) AS Age FROM Customers) LOOP
        IF rec.Age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = rec.CustomerID;
            DBMS_OUTPUT.PUT_LINE('Applied 1% discount for customer: ' || rec.Name || ' (Age: ' || rec.Age || ')');
        END IF;
    END LOOP;
    COMMIT;
END;
/

ALTER TABLE Customers ADD (IsVIP VARCHAR2(5) DEFAULT 'FALSE');

BEGIN
    FOR rec IN (SELECT CustomerID, Name, Balance FROM Customers) LOOP
        IF rec.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = rec.CustomerID;
            DBMS_OUTPUT.PUT_LINE('Customer ' || rec.Name || ' is now VIP (Balance: ' || rec.Balance || ')');
        END IF;
    END LOOP;
    COMMIT;
END;
/

BEGIN
    FOR rec IN (
        SELECT c.Name, l.LoanID, l.EndDate, l.LoanAmount
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Dear ' || rec.Name || ', your loan (ID: ' || rec.LoanID || ') of amount ' || rec.LoanAmount || ' is due on ' || TO_CHAR(rec.EndDate, 'DD-MON-YYYY') || '. Please ensure timely payment.');
    END LOOP;
END;
/
