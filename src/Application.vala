public class Variables.Application : Gtk.Application {
    public static unowned Vdi.Container container {
        get {
            return _container.once (() => new Vdi.Container ());
        }
    }

    private static GLib.Once<Vdi.Container> _container;

    public Application () {
        Object (application_id: Constants.APP_ID);
    }

    construct {
        Intl.setlocale (GLib.LocaleCategory.ALL, "");
        Intl.bindtextdomain (Constants.GETTEXT_PACKAGE, Constants.LOCALEDIR);
        Intl.bind_textdomain_codeset (Constants.GETTEXT_PACKAGE, "UTF-8");
        Intl.textdomain (Constants.GETTEXT_PACKAGE);
    }

    protected override void activate () {
        var main_window = this.get_active_window ();

        if (main_window == null) {
            main_window = new MainWindow (this) {
                title = _("Variables")
            };
        }

        main_window.present ();

        // Setup color scheme change events and theming
        var granite_settings = Granite.Settings.get_default ();
        var gtk_settings = Gtk.Settings.get_default ();
        gtk_settings.gtk_icon_theme_name = "elementary";

        if (!(gtk_settings.gtk_theme_name.has_prefix ("io.elementary.stylesheet"))) {
            gtk_settings.gtk_theme_name = "io.elementary.stylesheet.blueberry";
        }

        gtk_settings.gtk_application_prefer_dark_theme = (
            granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK
        );

        granite_settings.notify["prefers-color-scheme"].connect (() => {
            gtk_settings.gtk_application_prefer_dark_theme = (
                granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK
            );
        });

        // Remember window dimensions state
        var settings = new Settings (Constants.APP_ID);
        settings.bind ("window-height", main_window, "default-height", SettingsBindFlags.DEFAULT);
        settings.bind ("window-width", main_window, "default-width", SettingsBindFlags.DEFAULT);

        if (settings.get_boolean ("window-maximized")) {
            main_window.maximize ();
        }

        settings.bind ("window-maximized", main_window, "maximized", SettingsBindFlags.SET);
        var db_service = new Variables.DatabaseService ();

        try {
            db_service.init ();

        } catch (Error err) {
            error ("%s", err.message);
        }
    }
}

public static int main (string[] args) {
    var my_app = new Variables.Application ();
    return my_app.run (args);
}
