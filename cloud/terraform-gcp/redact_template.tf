resource "google_data_loss_prevention_deidentify_template" "basic" {
    parent = "projects/pa-igti"
    description = "Exemplo de Template para avaliar documento de re-escrever escondendo informações sensíveis"
    display_name = "redact-template"

    deidentify_config {
        info_type_transformations {
            transformations {
                info_types {
                    name = "DATE"
                }
                info_types {
                    name = "FEMALE_NAME"
                }
                primitive_transformation {
                    character_mask_config {
                        masking_character = "X"
                        number_to_mask = 4
                        reverse_order = true
                        characters_to_ignore {
                            common_characters_to_ignore = "PUNCTUATION"
                        }
                    }
                }
            }
        }
    }
}