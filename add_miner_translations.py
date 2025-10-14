#!/usr/bin/env python3
import json
import os

# Переводы для NDN Miner на разных языках
miner_translations = {
    "de": {
        "title": "NDN Miner",
        "stats": {
            "ndn_gas": "NDN Gas",
            "energy": "Energie",
            "gas_per_second": "Gas/sek"
        },
        "farms": {
            "title": "Mining-Farmen",
            "cpu_miner": "CPU Miner",
            "cpu_miner_desc": "Grundlegende Prozessor-Farm",
            "gpu_farm": "GPU Farm",
            "gpu_farm_desc": "Leistungsstarke Grafikkarten-Farm",
            "asic_rig": "ASIC Rig",
            "asic_rig_desc": "Professionelle ASIC-Farm",
            "data_center": "Data Center",
            "data_center_desc": "Mega-Farm im Rechenzentrum",
            "gas_per_sec": "Gas/sek",
            "energy_cost": "Energie",
            "quantity": "Anzahl",
            "cost": "Kosten",
            "buy": "Kaufen",
            "locked": "Gesperrt",
            "not_enough_gas": "Nicht genug Gas"
        },
        "upgrades": {
            "title": "Upgrades",
            "speed": "Geschwindigkeit",
            "efficiency": "Effizienz",
            "automation": "Automatisierung",
            "premium": "Premium",
            "speed_upgrades": {
                "fast_processor": "Schneller Prozessor",
                "fast_processor_desc": "+10% Geschwindigkeit",
                "code_optimization": "Code-Optimierung",
                "code_optimization_desc": "+25% Geschwindigkeit",
                "parallel_computing": "Parallele Berechnung",
                "parallel_computing_desc": "+50% Geschwindigkeit"
            },
            "efficiency_upgrades": {
                "energy_saving": "Energiesparen",
                "energy_saving_desc": "-20% Energie",
                "smart_cooling": "Intelligente Kühlung",
                "smart_cooling_desc": "-40% Energie",
                "quantum_optimization": "Quantenoptimierung",
                "quantum_optimization_desc": "-60% Energie"
            },
            "automation_upgrades": {
                "auto_collect": "Auto-Sammlung",
                "auto_collect_desc": "Automatische Gas-Sammlung",
                "smart_algorithms": "Intelligente Algorithmen",
                "smart_algorithms_desc": "Mining-Optimierung",
                "ai_management": "KI-Management",
                "ai_management_desc": "Vollständige Automatisierung"
            },
            "cost": "Kosten",
            "bought": "Gekauft",
            "max_level": "Max. Level",
            "not_enough_gas": "Nicht genug Gas"
        },
        "shop": {
            "title": "Shop",
            "energy_drink": "Energiedrink",
            "energy_drink_desc": "Stellt 50 Energie wieder her",
            "premium_booster": "Premium-Booster",
            "premium_booster_desc": "2x Geschwindigkeit für 1 Stunde",
            "golden_farm": "Goldene Farm",
            "golden_farm_desc": "Exklusive Farm",
            "buy": "Kaufen"
        },
        "leaderboard": {
            "title": "Miner-Rangliste",
            "rank": "Rang",
            "player": "Spieler",
            "gas_earned": "Gas verdient",
            "farms_count": "Farmen",
            "level": "Level",
            "you": "Du"
        }
    },
    "fr": {
        "title": "NDN Miner",
        "stats": {
            "ndn_gas": "NDN Gas",
            "energy": "Énergie",
            "gas_per_second": "Gas/sec"
        },
        "farms": {
            "title": "Fermes de minage",
            "cpu_miner": "CPU Miner",
            "cpu_miner_desc": "Ferme de base sur processeur",
            "gpu_farm": "GPU Farm",
            "gpu_farm_desc": "Ferme puissante sur cartes graphiques",
            "asic_rig": "ASIC Rig",
            "asic_rig_desc": "Ferme professionnelle ASIC",
            "data_center": "Data Center",
            "data_center_desc": "Méga-ferme en centre de données",
            "gas_per_sec": "Gas/sec",
            "energy_cost": "Énergie",
            "quantity": "Quantité",
            "cost": "Coût",
            "buy": "Acheter",
            "locked": "Verrouillé",
            "not_enough_gas": "Pas assez de Gas"
        },
        "upgrades": {
            "title": "Améliorations",
            "speed": "Vitesse",
            "efficiency": "Efficacité",
            "automation": "Automatisation",
            "premium": "Premium",
            "speed_upgrades": {
                "fast_processor": "Processeur rapide",
                "fast_processor_desc": "+10% vitesse",
                "code_optimization": "Optimisation du code",
                "code_optimization_desc": "+25% vitesse",
                "parallel_computing": "Calcul parallèle",
                "parallel_computing_desc": "+50% vitesse"
            },
            "efficiency_upgrades": {
                "energy_saving": "Économie d'énergie",
                "energy_saving_desc": "-20% énergie",
                "smart_cooling": "Refroidissement intelligent",
                "smart_cooling_desc": "-40% énergie",
                "quantum_optimization": "Optimisation quantique",
                "quantum_optimization_desc": "-60% énergie"
            },
            "automation_upgrades": {
                "auto_collect": "Auto-collecte",
                "auto_collect_desc": "Collecte automatique de Gas",
                "smart_algorithms": "Algorithmes intelligents",
                "smart_algorithms_desc": "Optimisation du minage",
                "ai_management": "Gestion IA",
                "ai_management_desc": "Automatisation complète"
            },
            "cost": "Coût",
            "bought": "Acheté",
            "max_level": "Niveau max",
            "not_enough_gas": "Pas assez de Gas"
        },
        "shop": {
            "title": "Boutique",
            "energy_drink": "Boisson énergétique",
            "energy_drink_desc": "Restaure 50 énergie",
            "premium_booster": "Booster premium",
            "premium_booster_desc": "2x vitesse pendant 1 heure",
            "golden_farm": "Ferme dorée",
            "golden_farm_desc": "Ferme exclusive",
            "buy": "Acheter"
        },
        "leaderboard": {
            "title": "Classement des mineurs",
            "rank": "Rang",
            "player": "Joueur",
            "gas_earned": "Gas gagné",
            "farms_count": "Fermes",
            "level": "Niveau",
            "you": "Vous"
        }
    }
}

# Добавляем переводы в файлы
for lang_code, translations in miner_translations.items():
    file_path = f"locales/{lang_code}.json"
    
    if os.path.exists(file_path):
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        data["miner"] = translations
        
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(data, f, ensure_ascii=False, indent=2)
        
        print(f"Added miner translations to {lang_code}.json")
    else:
        print(f"File {file_path} not found")

print("Miner translations added successfully!")
