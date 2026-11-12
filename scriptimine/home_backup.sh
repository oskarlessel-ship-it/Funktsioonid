
#!/bin/bash

# Kasutajate kodukataloogide varundamine
# Töötab sõltumata käivitamise asukohast

lahtekaust="/home"
sihtkaust="/home_bcp"
kuupaev=$(date +%d.%m.%Y)

mkdir -p "$sihtkaust"

for kataloog in "$lahtekaust"/*; do
    if [ -d "$kataloog" ]; then
        kasutaja=$(basename "$kataloog")
        arhiiv="$sihtkaust/$kasutaja.$kuupaev.tar.gz"

        echo "Varundan: $kasutaja"

        if tar -czf "$arhiiv" -C "$lahtekaust" "$kasutaja"; then
            sha256sum "$arhiiv" > "$arhiiv.sha256"
            echo "Valmis: $arhiiv"
        else
            echo "VIGA: $kasutaja"
            rm -f "$arhiiv"
        fi
    fi
done
