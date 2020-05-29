# projeto-aplicado
Repositório para manter o código referente ao meu projeto aplicado

# Badge para avisos do status das builds no CircleCi

[![CircleCI](https://circleci.com/gh/dodopontocom/projeto-aplicado/tree/develop.svg?style=svg)](https://circleci.com/gh/dodopontocom/projeto-aplicado/tree/develop)

# Estrutura dos diretórios

```
.circleci
├── vars-ambientes
│    ├── prod.sh
│    ├── dev.sh
│    └── int.sh
└── config.yml
cloud
├── credentials
├── terraform
│    ├── apis.tf
│    ├── backend.tf
│    ├── gce.tf
│    ├── output.tf
│    ├── provider.tf
│    ├── terraform.tfvars
│    ├── variables.tf
│    └── vpc.tf
app
```
