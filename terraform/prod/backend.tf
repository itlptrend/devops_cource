#Храним state в бакете гугла. Бакет создал из корневой диры. Сначала бакет, потом в этой папку terraform init.
#Это явно не праивльно.
terraform {
  backend "gcs" {
    bucket = "shikanov-terraform-state"
    prefix = "stage"
  }
}