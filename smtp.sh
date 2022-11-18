#!/bin/bash
# Mail Parameters
read -p "Informe servidor SMTP: " mail_server
read -p "Informe a porta do servidor: " mail_port
read -p "Informe o protocolo a ser usado: " mail_protocol
read -p "Informe remetente: " mail_from
read -p "Informe destinatário: " rcpt_to
read -p "Informe o assunto: " mail_subject
read -p "Informe o conteúdo do e-mail: " mail_content

openssl s_client -connect $mail_server:$mail_port -starttls $mail_protocol <<EOF
EHLO $mail_server
MAIL FROM: $mail_from
rcpt to: $rcpt_to NOTIFY=success,failure
DATA
date: `date +%a,\ %d\ %b\ %Y\ %H:%M:%S\ %z`
from: $mail_from
to: $rcpt_to
List-Unsubscribe: mailto: $mail_from
Subject: $mail_subject
$mail_content
.
quit
EOF
