# Feature Specification: Jellyfin First Container

**Feature Branch**: `001-jellyfin-container`  
**Created**: 2025-12-27  
**Status**: Draft  
**Input**: User description: "Das erste richtige container. Bitte den Nginx wegmachen. und wir fangen ganz simpel bei 40.1,2,3... an. Der ERste container wird Jellyfin. Media sind die beiden USB platten. Die metadaten sollen an einem vernuftigen ord wo spaeter alle volumes der container persistet werden umm das back einfach zu machen. Dazu noch eine Firwallrule das nur diese mac adresse von achielles jellyfin erreichen kann."

## Clarifications

### Session 2025-12-27

- Q: Welches Subnetz soll fuer 40.1/40.2/40.3 verwendet werden? → A: 192.168.40.0/24 (Gateway 192.168.40.1, Jellyfin 192.168.40.3, keine Reserve)

## User Scenarios & Testing _(mandatory)_

### User Story 1 - Jellyfin Zugriff vom Achilles-Device (Priority: P1)

Als Betreiber moechte ich Jellyfin nur vom Achilles-Device erreichen koennen,
damit der Zugriff kontrolliert und sicher bleibt.

**Why this priority**: Zugriffsschutz ist die wichtigste Voraussetzung vor jeder Nutzung.

**Independent Test**: Vom Achilles-Device ist die Jellyfin-Oberflaeche erreichbar;
von anderen Geraeten wird der Zugriff blockiert.

**Acceptance Scenarios**:

1. **Given** Jellyfin ist bereitgestellt, **When** das Achilles-Device zugreift,
   **Then** wird der Zugriff erlaubt.
2. **Given** Jellyfin ist bereitgestellt, **When** ein anderes Geraet zugreift,
   **Then** wird der Zugriff blockiert.

---

### User Story 2 - Medienbibliothek aus zwei USB-Platten (Priority: P2)

Als Betreiber moechte ich die Medien aus beiden USB-Platten in Jellyfin sehen,
damit die gesamte Bibliothek verfuegbar ist.

**Why this priority**: Ohne Medieninhalte hat Jellyfin keinen Nutzen.

**Independent Test**: Medien aus beiden USB-Platten erscheinen in der Bibliothek
und sind abspielbar.

**Acceptance Scenarios**:

1. **Given** beide USB-Platten sind angeschlossen, **When** die Bibliothek gescannt wird,
   **Then** Inhalte von beiden Platten erscheinen.
2. **Given** Medien sind gelistet, **When** ein Titel abgespielt wird,
   **Then** startet die Wiedergabe erfolgreich.

---

### User Story 3 - Zentrale Metadaten-Persistenz (Priority: P3)

Als Betreiber moechte ich Metadaten an einem zentralen Ort speichern, damit
Backups spaeter fuer alle Container-Volumes einfach bleiben.

**Why this priority**: Ein konsistenter Persistenz-Ort reduziert Backup-Aufwand.

**Independent Test**: Nach einem Neustart bleiben Bibliothek und Metadaten erhalten.

**Acceptance Scenarios**:

1. **Given** Metadaten wurden erzeugt, **When** der Container neu startet,
   **Then** bleiben Metadaten und Einstellungen erhalten.
2. **Given** der zentrale Persistenz-Ort wird gesichert, **When** ein Restore erfolgt,
   **Then** sind Metadaten weiterhin verfuegbar.

---

### Edge Cases

- Was passiert, wenn eine der USB-Platten fehlt oder nicht gemountet ist?
- Wie verhaelt sich das System, wenn der zentrale Persistenz-Ort nicht verfuegbar ist?
- Wie wird der Zugriff behandelt, wenn das Achilles-Device eine neue MAC-Adresse hat?

## Requirements _(mandatory)_

### Functional Requirements

- **FR-001**: Das System MUSS den bisherigen Nginx-Dienst fuer diesen Anwendungsfall entfernen
  bzw. nicht mehr bereitstellen.
- **FR-002**: Das System MUSS Jellyfin als ersten produktiven Container bereitstellen.
- **FR-003**: Der Zugriff auf Jellyfin MUSS ausschliesslich vom Achilles-Device erlaubt sein.
- **FR-004**: Die Medienquelle MUSS aus genau zwei USB-Platten bestehen.
- **FR-005**: Metadaten MUESSEN an einem zentralen, persistenten Ort gespeichert werden,
  der fuer spaetere Container-Backups wiederverwendbar ist.
- **FR-006**: Die simple Nummerierung/Adressierung 40.1, 40.2, 40.3 MUSS klar definiert
  und angewendet werden: Subnetz 192.168.40.0/24, 40.1 ist das Gateway (192.168.40.1),
  40.2 bleibt frei, Jellyfin nutzt 40.3 (192.168.40.3), keine Reserve.
- **FR-007**: Die MAC-Adresse des Achilles-Devices MUSS als Zugriffskriterium
  festgelegt werden: `0C:37:96:09:34:DA`.

Die Anforderungen werden ueber die Akzeptanzszenarien und Edge Cases verifiziert.

### Key Entities _(include if feature involves data)_

- **USB-Medium**: Physische Datentraeger mit Medieninhalten, Quelle der Bibliothek.
- **Jellyfin-Metadaten**: Persistente Bibliotheks- und Konfigurationsdaten.
- **Achilles-Device**: Das einzige zugelassene Client-Geraet fuer den Zugriff.

## Success Criteria _(mandatory)_

### Measurable Outcomes

- **SC-001**: 100% der Zugriffsversuche von nicht autorisierten Geraeten werden blockiert.
- **SC-002**: Medien von beiden USB-Platten erscheinen in der Bibliothek nach einem Scan.
- **SC-003**: Nach einem Neustart bleiben Bibliothek und Metadaten vollstaendig erhalten.
- **SC-004**: Der zentrale Persistenz-Ort ermoeglicht ein komplettes Backup in einem Schritt.
- **SC-005**: Der bisherige Nginx-Dienst ist nicht mehr erreichbar.

## Assumptions

- Jellyfin ist der erste produktive Container in diesem Segment.
- Ein zentraler Persistenz-Ort auf dem Host ist vorgesehen und kann gesichert werden.
- Die USB-Platten sind dauerhaft am System angeschlossen und fuer Medien vorgesehen.
