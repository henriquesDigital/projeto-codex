from flask import Flask, render_template, request, redirect, url_for
import csv
import os
from urllib.parse import quote

app = Flask(__name__)

CSV_FILE = 'respostas.csv'

def salvar_resposta(dados):
    existe = os.path.exists(CSV_FILE)
    with open(CSV_FILE, 'a', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        if not existe:
            writer.writerow(['nome', 'empresa', 'segmento', 'conhece', 'meta'])
        writer.writerow([
            dados['nome'],
            dados['empresa'],
            dados['segmento'],
            dados['conhece'],
            dados['meta']
        ])

def gerar_link_whatsapp(nome, segmento):
    mensagem = (
        f"Olá, meu nome é {nome}, sou do segmento {segmento}.\n"
        "Acabei de preencher o formulário no site e estou interessado em investir em tráfego pago.\n"
        "Podemos conversar sobre a melhor estratégia para minha empresa?"
    )
    return 'https://wa.me/5562992002280?text=' + quote(mensagem)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/quiz')
def quiz():
    return render_template('quiz.html')

@app.route('/resultado', methods=['POST'])
def resultado():
    dados = {
        'nome': request.form.get('nome', ''),
        'empresa': request.form.get('empresa', ''),
        'segmento': request.form.get('segmento', ''),
        'conhece': request.form.get('conhece', ''),
        'meta': request.form.get('meta', '')
    }
    salvar_resposta(dados)
    link = gerar_link_whatsapp(dados['nome'], dados['segmento'])
    return render_template('resultado.html', whatsapp_link=link, nome=dados['nome'], segmento=dados['segmento'])

@app.route('/nao')
def nao():
    nome = request.args.get('nome', '')
    segmento = request.args.get('segmento', '')
    link = gerar_link_whatsapp(nome, segmento)
    return render_template('obrigado.html', whatsapp_link=link)

if __name__ == '__main__':
    app.run(debug=True)
