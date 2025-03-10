--liquibase formatted sql

--changeset authornamehere:20250228001
--comment Add test data for development environment
--context dev
--runAlways true

-- Only execute if Test Template doesn't exist
-- Note: precondition checks are handled differently in SQL format with onFail="MARK_RAN"
-- We achieve the same using liquibase's built-in preconditions
--preconditions onFail:MARK_RAN
--precondition-sql-check expectedResult:0 SELECT COUNT(*) FROM template_service.template WHERE name = 'Test Template'

-- Insert test template
INSERT INTO template_service.template (id, name, category_id, content, format, version, is_active, created_by)
SELECT uuid_generate_v4(),
       'Test Template',
       id,
       '<html>
       <head>
         <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
       </head>
       <body class="bg-gray-50 font-sans">
         <div class="max-w-2xl mx-auto my-10 bg-white rounded-lg shadow-lg overflow-hidden">
           <div class="bg-blue-600 text-white px-6 py-4">
             <h1 class="text-2xl font-bold">Hello, {{.name}}!</h1>
           </div>
           <div class="px-6 py-8">
             <p class="text-gray-700 mb-6">
               This is a <span class="font-semibold">test template</span>. Feel free to modify.
             </p>
             <div class="bg-blue-50 rounded-lg p-4 border border-blue-200">
               <h2 class="text-xl font-semibold text-blue-800 mb-3">Details:</h2>
               <ul class="space-y-2 text-gray-700">
                 <li class="flex"><span class="font-medium w-32">Name:</span> {{.name}}</li>
               </ul>
             </div>
         </div>
       </body>
       </html>',
       'html',
       1,
       true,
       'system'
FROM template_service.template_category
WHERE name = 'Email';

-- Add template variable
INSERT INTO template_service.template_variable (template_id, variable_name, description, default_value, is_required)
SELECT id, 'name', 'Recipient name', 'User', true
FROM template_service.template
WHERE name = 'Test Template';

--changeset authornamehere:20250228002
--comment Add Invoice Template
--context dev
--runAlways true
--preconditions onFail:MARK_RAN
--precondition-sql-check expectedResult:0 SELECT COUNT(*) FROM template_service.template WHERE name = 'Invoice Template'

-- Insert invoice template
INSERT INTO template_service.template (id, name, category_id, content, format, version, is_active, created_by)
SELECT uuid_generate_v4(),
       'Invoice Template',
       id,
       '<html>
       <head>
         <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
       </head>
       <body class="bg-gray-50 font-sans p-8">
         <div class="max-w-3xl mx-auto bg-white rounded-lg shadow-lg overflow-hidden">
           <div class="bg-blue-600 text-white px-6 py-4">
             <h1 class="text-2xl font-bold">INVOICE</h1>
           </div>
           <div class="p-6">
             <div class="mb-6 grid grid-cols-2 gap-4">
               <p><span class="font-medium">Invoice Date:</span> {{.date}}</p>
               <p><span class="font-medium">Invoice Number:</span> {{.invoice_number}}</p>
             </div>

             <h2 class="text-xl font-semibold text-blue-800 mb-3">Customer Information</h2>
             <div class="mb-6 grid grid-cols-2 gap-4">
               <p><span class="font-medium">Name:</span> {{.customer_name}}</p>
               <p><span class="font-medium">Email:</span> {{.customer_email}}</p>
             </div>

             <h2 class="text-xl font-semibold text-blue-800 mb-3">Items</h2>
             <table class="w-full border-collapse mb-6">
               <thead>
                 <tr>
                   <th style="border: 1px solid #babdb6; padding: 8px;">Quantity</th>
                   <th style="border: 1px solid #babdb6; padding: 8px;">Price</th>
                   <th style="border: 1px solid #babdb6; padding: 8px;">Total</th>
                 </tr>
               </thead>
               <tbody>
                 <tr>
                   <td style="border: 1px solid #babdb6; padding: 8px;">Product A</td>
                   <td style="border: 1px solid #babdb6; padding: 8px;">2</td>
                   <td style="border: 1px solid #babdb6; padding: 8px;">$50.00</td>
                   <td style="border: 1px solid #babdb6; padding: 8px;">$100.00</td>
                 </tr>
                 <tr>
                   <td style="border: 1px solid #babdb6; padding: 8px;">Product B</td>
                   <td style="border: 1px solid #babdb6; padding: 8px;">1</td>
                   <td style="border: 1px solid #babdb6; padding: 8px;">$75.00</td>
                   <td style="border: 1px solid #babdb6; padding: 8px;">$75.00</td>
                 </tr>
               </tbody>
             </table>

             <h2 class="bluecurve-subtitle mt-4">Summary</h2>
             <p><strong>Subtotal:</strong> $175.00</p>
             <p><strong>Tax (10%):</strong> $17.50</p>
             <p><strong>Total:</strong> $192.50</p>
           </div>
         </div>
       </body>
       </html>',
       'html',
       1,
       true,
       'system'
FROM template_service.template_category
WHERE name = 'Report';

-- Add template variables
INSERT INTO template_service.template_variable (template_id, variable_name, description, default_value, is_required)
SELECT id, 'date', 'Invoice date', '2023-01-01', true
FROM template_service.template
WHERE name = 'Invoice Template';

INSERT INTO template_service.template_variable (template_id, variable_name, description, default_value, is_required)
SELECT id, 'invoice_number', 'Invoice number', 'INV-001', true
FROM template_service.template
WHERE name = 'Invoice Template';

INSERT INTO template_service.template_variable (template_id, variable_name, description, default_value, is_required)
SELECT id, 'customer_name', 'Customer name', 'John Doe', true
FROM template_service.template
WHERE name = 'Invoice Template';

INSERT INTO template_service.template_variable (template_id, variable_name, description, default_value, is_required)
SELECT id, 'customer_email', 'Customer email', 'john.doe@example.com', true
FROM template_service.template
WHERE name = 'Invoice Template';

--changeset authornamehere:20250228003
--comment Add test configuration
--context dev
--runAlways true
--preconditions onFail:MARK_RAN
--precondition-sql-check expectedResult:0 SELECT COUNT(*) FROM template_service.configuration WHERE config_key = 'test_mode'

INSERT INTO template_service.configuration (config_key, config_value, description)
VALUES ('test_mode', 'true', 'Enable test mode in development');