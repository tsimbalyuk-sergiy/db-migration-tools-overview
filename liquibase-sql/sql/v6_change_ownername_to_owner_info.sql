--liquibase formatted sql

--changeset authornamehere:6
--comment Change ownername to owner_info with JSONB type

SET search_path TO template_service, public;

ALTER TABLE template_service.configuration
ADD COLUMN owner_info JSONB DEFAULT '{}'::jsonb NOT NULL;

UPDATE template_service.configuration
SET owner_info = CASE 
    WHEN ownername IS NOT NULL THEN jsonb_build_object('name', ownername)
    ELSE '{}'::jsonb 
END;

ALTER TABLE template_service.configuration DROP COLUMN ownername;

INSERT INTO template_service.system_info (version, description)
VALUES ('1.0.5', 'Changed ownername to owner_info with JSONB type');

