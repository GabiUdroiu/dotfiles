#!/bin/bash

EWW_WINDOW_NAME="testold"
EWW_VAR_NAME="reveal_topbar"

# Verifică starea curentă a revealer-ului, nu a ferestrei
REVEAL_STATE=$(eww get "$EWW_VAR_NAME" 2>/dev/null)

if [ "$REVEAL_STATE" = "true" ]; then
    # Dacă revealer-ul este vizibil, ascunde-l cu animație.
    eww update "$EWW_VAR_NAME"=false
    # Așteaptă ca animația să se termine (dacă ai pus o durată în revealer, de ex. 500ms).
    # Apoi, închide fereastra complet.
    eww close "$EWW_WINDOW_NAME"
else
    # Dacă fereastra nu este deschisă sau conținutul ei e ascuns, o deschide.
    eww open "$EWW_WINDOW_NAME"
    # Așteaptă un moment scurt pentru a lăsa fereastra să se încarce.
    sleep 0.05
    # Declansează animația de apariție.
    eww update "$EWW_VAR_NAME"=true
fi