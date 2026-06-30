public class Main {
    public static void main(String[] args) {

        DocumentFactory pdfFactory = new PdfFactory();
        pdfFactory.createDocument().open();

        DocumentFactory wordFactory = new WordFactory();
        wordFactory.createDocument().open();

        DocumentFactory excelFactory = new ExcelFactory();
        excelFactory.createDocument().open();
    }
}