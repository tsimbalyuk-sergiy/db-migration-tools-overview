SET search_path TO template_service, public;

ALTER TABLE template_service.configuration
ADD COLUMN ownername VARCHAR(200);

INSERT INTO template_service.system_info (version, description)
VALUES ('1.0.4', 'Added ownername field to configuration table');
