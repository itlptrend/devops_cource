# devops_cource

GCP
gcloud auth login gcpshikanov
gcloud config set project shikanov-project
#инстанс
 gcloud compute instances create reddit-app \
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags puma-server \
--restart-on-failure \
--zone=europe-west4-a \
--metadata-from-file startup-script=startup_script.sh
#правило фаервола
gcloud compute firewall-rules create puma-server --allow tcp:9292 --target-tags=puma-server
#удалил
gcloud compute instances delete reddit-app2 --zone=europe-west4-a

#Это для их CI
testapp_IP = 35.198.167.169
testapp_port = 9292

     lesson7  PACKER
gcloud auth application-default login //креды делает в  /home/ashikanov/.config/gcloud/application_default_credentials.json
packer build ubuntu16.json
packer build -var-file file ubuntu16.json
packer build -var 'gcp_project_id=shikanov-project' -var 'source_image_family=ubuntu-1604-lts'  ubuntu16.json


	Lesson8 Terrafirm1  Версию взял 1.12, у них 1.11
terraform init
terraform  plan
terraform  apply -auto-approve=true
terraform show | grep nat_ip //или cat terraform.tfstate | grep nat_ip
terraform refresh //назначит переменную из outputs.tf
terraform output //покажет переменные из output
  провижинеры выполняются по порядку их определения
  провижинеры по умолчанию запускаются сразу после создания ресурса(могут еще запускаться после его удаления)
terraform taint google_compute_instance.app //пометить ресурс для пересоздания при след apply
terraform plan
terraform apply
terraform  destroy
terraform fmt //форматирует файлы?
  ssh ключи. Он их удаляет и добавляет, когда убираеш или добавляеш в конфиг. Похоже хранит инфу в terraform.tfstate (проверить)