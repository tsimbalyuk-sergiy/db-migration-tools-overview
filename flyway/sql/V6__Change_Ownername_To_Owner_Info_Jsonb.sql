SET search_path TO template_service, public;

ALTER TABLE template_service.configuration
ADD COLUMN owner_info JSONB DEFAULT '{}'::jsonb;

UPDATE template_service.configuration
SET owner_info = CASE 
    WHEN ownername IS NOT NULL THEN jsonb_build_object('name', ownername)
    ELSE '{}'::jsonb 
END;

ALTER TABLE template_service.configuration DROP COLUMN ownername;

