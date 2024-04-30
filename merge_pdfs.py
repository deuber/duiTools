import os
import sys
from PyPDF2 import PdfReader, PdfWriter

def merge_pdfs(folder_path, output_path):
    pdf_writer = PdfWriter()

    for item in sorted(os.listdir(folder_path)):
        if item.endswith('.pdf'):
            file_path = os.path.join(folder_path, item)
            pdf_reader = PdfReader(file_path)

            for page in pdf_reader.pages:
                pdf_writer.add_page(page)

    with open(output_path, 'wb') as out:
        pdf_writer.write(out)

if __name__ == "__main__":
    folder = sys.argv[1]
    output_file = 'appended_knowledge.pdf'
    merge_pdfs(folder, output_file)
    print(f"Merged PDFs from {folder} into {output_file}")

