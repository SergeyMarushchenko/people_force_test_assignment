# README

The functionality is implemented accordng to the EAV pattern. This allows to extend functionality so that not only user can use custom fields.

During the implementation following assumptions are made:

* Field name is case sensitive;

* Field name should be unique for a tenant;

* The `tenants_controller#update` endpoint expects array oh hashes `[{ name:, data_type:, :allowed_values }]`.
  - The `data_type` attribute can take the following 4 possible values: `['text', 'number', 'single_select', 'multi_select']`.
  - The `allowed_values` attribute is required for `single_select` and `multi_select` data types.

* The `users_controller#update_value` endpoint expects array oh hashes `[{ name:, value: }]`.
  - Value for `text` type field is expected to be `String`.
  - Value for `number` type field is generally expected to be `Numeric`, but will be casted and stored as `String` anyway.
  - Value for `single_select` type field is expected to be `String`.
  - Value for `multi_select` type field is expected to be `Array` of `Strings`.

- For retrieving data `User#get(name)` method is implemented, it returns field value by field name.
- `tenants_controller#update` and `users_controller#update_value` has basic test coverage.
- There are also some demo data in `seeds.rb`.
