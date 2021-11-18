import requests
from bs4 import BeautifulSoup
import csv

def datosLista(title, company, location, url):
  lista = []
  lista.append(title)
  lista.append(company)
  lista.append(location)
  lista.append(url)
  return lista

URL = "https://realpython.github.io/fake-jobs/"
page = requests.get(URL)

soup = BeautifulSoup(page.content, "html.parser")
results = soup.find(id="ResultsContainer")

job_elements = results.find_all("div", class_="card-content")


python_jobs = results.find_all(
    "h2", string=lambda text: "python" in text.lower()
    )

python_jobs_elements = (
        h2_element.parent.parent.parent for h2_element in python_jobs
    )

# Crear listas donde se van a guardar listas de los trabajos
listaDefinitiva = []

for job_element in python_jobs_elements:
    title_element = job_element.find("h2", class_="title")
    company_element = job_element.find("h3", class_="company")
    location_element = job_element.find("p", class_="location")
    link_url = job_element.find_all("a")[1]["href"]
    print(title_element.text.strip())
    print(company_element.text.strip())
    print(location_element.text.strip())
    print(f"Apply here: {link_url}\n")
    # Mandar los elementos actuales a la funcion para generar una lista
    listaDefinitiva.append(datosLista(title_element.text.strip(),company_element.text.strip(),location_element.text.strip(),link_url))
    
with open('./fakejobs.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerows(listaDefinitiva)