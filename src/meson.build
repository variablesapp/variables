app_dependencies = [
    global_dependencies,
    dependency('gtk4'),
    dependency('granite-7'),
    dependency('template-glib-1.0'),
    dependency('vadi-0.0'),
    dependency('sqlite3', version: '>= 3.5.9'),
]

app_sources = [
    files(
        'Application.vala',
        'Constants/Config.vala',
        'Enums/EditableFieldChangeType.vala',
        'Helpers/Debouncer.vala',
        'View/MainWindow.vala',
        'Model/Template.vala',
        'Model/Variable.vala',
        'Services/DatabaseService.vala',
        'Services/OutputService.vala',
        'ViewModel/MainViewModel.vala',
        'ViewModel/TemplateViewModel.vala',
        'ViewModel/TemplatesViewModel.vala',
        'ViewModel/VariablesViewModel.vala',
        'View/TemplateView.vala',
        'View/TemplatesView.vala',
        'View/VariablesView.vala',
        'Widgets/EditableField.vala',
        'db/DatabaseTable.vala',
        'db/TemplateTable.vala',
    ),
    config_file
]
