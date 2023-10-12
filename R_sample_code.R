# -------------------------------------------------------------------------
## Script for data cleaning of the database for the UFES entrance exam
## Author: Amanda Pena
## Project: Master's dissertation/thesis
## Date: 10-12-2023
# -------------------------------------------------------------------------

# Loading packages using packman ----------------------------------------

packages <- c(
  "readxl", "here", "data.table", "dplyr", "stringr", "tidyverse", "magrittr",
  "writexl"
  
)

# If the package is not installed, then install it 
if (!require("pacman")) install.packages("pacman")

# Load the packages 
pacman::p_load(packages, character.only = TRUE, install = TRUE)

# Loading files using here package

here()
path <- here("data", "data_ufes_approved_reserve.xlsx")
df_ufes <- read_xlsx(path)
colnames(df_ufes)


# Cleaning ----------------------------------------------------------------

# Correcting typos
df_ufes <- df_ufes %>%
  mutate(
    `Sist.Inclusão Social/ Reserva de Vagas` = case_when(
      `Sist.Inclusão Social/ Reserva de Vagas` %in% c("Optant", "Optan") ~ "Optante",
      `Sist.Inclusão Social/ Reserva de Vagas` == "Não Optant" ~ "Não Optante",
      TRUE ~ `Sist.Inclusão Social/ Reserva de Vagas`
    )
  )

# Creating an indicator per course/career
cursos <- unique(df_ufes$Curso)
print(cursos)
indice_cursos <- data.frame(
  Curso = cursos,
  Indice = 1:length(cursos)
)

# Creating an indicator for affirmative actions
aa_ind <- unique(df_ufes$`Sist.Inclusão Social/ Reserva de Vagas`)
print(aa_ind)
indice_sistema_inclusao <- data.frame(
  Sistema_Inclusao = cotas,
  Indice = 1:length(cotas)
)

# Creating an indicator with minimum and maximum grades per course and per year
notas <- df_ufes %>%
  group_by(Ano, Curso, Situação, `Sist.Inclusão Social/ Reserva de Vagas`) %>%
  summarise(
    Nota_Maxima = max(Pontuação),
    Nota_Minima = min(Pontuação)
  )
colnames(notas)

# Calculating the threshold for each course in each year
pontos_corte <- df_ufes %>%
  filter(Situação == "Aprovado") %>%
  group_by(Ano, Curso, `Sist.Inclusão Social/ Reserva de Vagas`) %>%
  summarise(Pontuacao_Corte = min(Pontuação))

notas <- notas %>%
  left_join(pontos_corte, by = c("Ano", "Curso", "Sist.Inclusão Social/ Reserva de Vagas"))

# Winsorizing the grades --------------------------------------------------


# Assuming 'df_ufes' is your original dataframe and 'pontos_corte_transformados' is the dataframe with the transformed cutoff scores

# Joining with the corresponding cutoff scores
df_ufes_ponto_corte <- df_ufes %>%
  left_join(notas, by = c("Ano", "Curso", "Sist.Inclusão Social/ Reserva de Vagas"))

# Subtracting the cutoff score from each score to standardize
df_ufes_padronizado <- df_ufes_ponto_corte %>%
  mutate(Pontuacao_Padronizada = Pontuação - Pontuacao_Corte) %>% #The standard grade is = Grade-Cutoff
  select(-Semestre, -Ordem, -Situação.x, -Nota_Maxima, -Nota_Minima) 


# Saving the files created ------------------------------------------------

# Write 'notas' to an Excel file
write_xlsx(notas, path = here("data", "notas.xlsx"))

# Write 'pontos_corte' to an Excel file
write_xlsx(pontos_corte, path = here("data", "pontos_corte.xlsx"))

# Write 'df_ufes_ponto_corte' to an Excel file
write_xlsx(df_ufes_ponto_corte, path = here("data", "df_ufes_ponto_corte.xlsx"))

# Write 'df_ufes_padronizado' to an Excel file
write_xlsx(df_ufes_padronizado, path = here("data", "df_ufes_padronizado.xlsx"))

















