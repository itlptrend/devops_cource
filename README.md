# devops_cource

GCP
gcloud auth login $username //google account username
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
#посмотреть фаервол правила.
gcloud compute firewall-rules list
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
#deug
packer -debug //создаст ключ, поменя права на 600. Будет спрашивать тебя после кадого действия
packer build -var-file ./packer/variables.json ./packer/db_ansible.json
ssh -i gce_googlecompute.pem packer@34.78.14.139

    	Lesson8 Terrafirm1  Версию взял 1.12, у них 1.11
terraform структура диров пример. Токо не понятно, как разные диры запускать. Т.к terraform будет весь проект приводить к состоянию. и если ты запустиш из redis он удалит все остальное. Мб Модулями?
/prod
  ./redis
  ./front
  ./back
/dev
  ./redis
  ./front
  ./back

terraform init
terraform  plan
terraform  apply -auto-approve=true
terraform show | grep nat_ip //или cat terraform.tfstate | grep nat_ip
terraform refresh //назначит переменную из outputs.tf
terraform output //покажет переменные из output
  провижинеры выполняются по порядку их определения
  провижинеры по умолчанию запускаются сразу после создания ресурса(могут еще запускаться после его удаления)
terraform taint google_compute_instance.app //пометить ресурс для пересоздания при след apply. Это например для provision нужно
terraform plan
terraform apply
terraform  destroy
terraform fmt //форматирует файлы?
  ssh ключи. Он их удаляет и добавляет, когда убираеш или добавляеш в конфиг. Похоже хранит инфу в terraform.tfstate (проверить)

terraform import google_compute_firewall.firewall_ssh default-allow-ssh   //импорт ресурсов созданных не через терраформ. В данном случае дефолт правело фаервола в state файл. Иначе будет ругаться, ибо ресурс уже есть, а он его будет хотеть создать.

  Зависимости.
Сначала сделает IP, потом будет создавать виртуалку. Смотри main.tf. 
depends_on  - явная зависимость

  Модули
# Есть готовые модули в registry Verified это модули от HashiCorp и ее партнеров.
# https://registry.terraform.io/browse/modules?provider=google
# https://registry.terraform.io/modules/SweetOps/storage-bucket/google/0.3.1
Можно писать самому. примеры есть, тут.
terraform get


tree .terraform

      #state
в корне storage-bucket.tf. делаем terraform.init, terraform apply.
Бакет создан.
идем в prod.
там создан конфиг backend.tf 
terraform init //послеэ того он переместит все в бакет
     #taint module. Когда надо пересоздать конкретный ресурс.
terraform  show | less
terraform taint  module.db.google_compute_instance.db[0]


      ansible
ansible-galaxy init name //создаст папку роли и структуру
Директория group_vars , созданная в директории плейбука или инвентори файла позволяет создавать файлы (имена, которых должны соответствовать названиям групп в ин
#galaxy hоли добавь в gitignore
ansible-playbook -i environments/prod/inventory playbooks/site.yml -С
ansible-playbook  playbooks/site.yml -С //в ansible.cfg указан environments/stage/inventory
  #vault
#в конфиге указан vault_password_file = vault.key. им и шифрует
ansible-vault encrypt environments/prod/credentials.yml 
ansible-vault edit <file>  //edit
ansible-vault decrypt <file>  //decrypt
  #ВАЖНО! На версии 2.7. при зашифровывании  environments/stage/credentials.yml(Ключ в ansible.cfg). и запуске
ansible-playbook playbooks/users.yml  //он выдовал ошибку! 
Unexpected Exception, this is probably a bug: 'ascii' codec can't decode byte 0xd0 in position 53: ordinal not in range(128)
В 2.9 версии это пофиксили. ПО этэому решил расшифровать.

  #Добавить в тревис
  #Необходимо, чтобы для коммитов в master и PR выполнялись как минимум эти действия:
packer validate для всех шаблонов   //packer validate -var-file ./packer/variables.json ./packer/app_ansible.json
terraform validate и tflint для окружений stage и prod
ansible-lint для плейбуков Ansible
Для отладки прохождения тестов советуем воспользоваться "trytravis".

