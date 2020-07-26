(define-module (planner)
  #:use-module (gnu packages calendar)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages inkscape)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages pantheon)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages)
  #:use-module (guix build-system meson)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) :prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils))

(define-public pantheon-gtk-theme
  (package
    (name "pantheon-gtk-theme")
    (version "5.4.2")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/elementary/stylesheet.git")
                    (commit version)))
              (file-name (git-file-name name version))
              (sha256
               (base32 "0aqq0d21mqgrfiyhpfa8k51wxw2pia0qlsgp0sli79v7nwn3ykbq"))))
    (native-inputs
     `(("gettext" ,gettext-minimal)))
    (build-system meson-build-system)
    (home-page "https://github.com/elementary/stylesheet")
    (synopsis "GTK theme for Pantheon")
    (description "Theme for the Pantheon desktop environment using a custom
designed GTK-CSS stylesheet.")
    (license license:gpl3+)))

(define-public pantheon-icon-theme
  (package
    (name "pantheon-icon-theme")
    (version "5.3.1")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/elementary/icons.git")
                    (commit version)))
              (sha256
               (base32 "0rs68cb39r9vq85pr8h3mgmyjpj8bkhkxr5cz4cn5947kf776wg9"))))
    (build-system meson-build-system)
    (arguments
     `(#:configure-flags
       (list "-Dvolume_icons=false")))
    (native-inputs
     `(("pkg-config" ,pkg-config)
       ("gettext" ,gettext-minimal)
       ("inkscape" ,inkscape)
       ("xcursorgen" ,xcursorgen)
       ("librsvg" ,librsvg)))
    (inputs
     `(("gtk+" ,gtk+)))
    (propagated-inputs
     `(("hicolor-icon-theme" ,hicolor-icon-theme)))
    (home-page "https://github.com/elementary/icons")
    (synopsis "Icons for Pantheon")
    (description "Vector icon theme for Pantheon.  It is not a comprehensive
universal icon set; its coverage is tailored for the software available in
elementary OS, for which Pantheon is the first-party desktop environment.")
    (license license:gpl3+)))

(define-public planner
  (package
    (name "planner")
    (version "2.4.6")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/alainm23/planner.git")
             (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0z0997yq809wbsk3w21xv4fcrgqcb958qdlksf4rhzhfnwbiii6y"))))
    (build-system meson-build-system)
    (arguments
     `(#:glib-or-gtk? #t
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'disable-schema-cache-generation
           (lambda _
             (setenv "DESTDIR" "/")
             #t)))))
    (inputs
     `(("evolution-data-server" ,evolution-data-server)
       ("granite" ,granite)
       ("glib" ,glib)
       ("gsettings-desktop-schemas" ,gsettings-desktop-schemas)
       ("gtk" ,gtk+)
       ("json-glib" ,json-glib)
       ("libgee" ,libgee)
       ("libical" ,libical)
       ("libsoup" ,libsoup-minimal)
       ("pantheon-gtk-theme" ,pantheon-gtk-theme)
       ("pantheon-icon-theme" ,pantheon-icon-theme)
       ("webkitgtk" ,webkitgtk)))
    (native-inputs
     `(("cmake" ,cmake)
       ("glib:bin" ,glib "bin") ; for glib-compile-schemas
       ("gettext" ,gettext-minimal)
       ("pkg-config" ,pkg-config)
       ("vala" ,vala)))
    (home-page "https://github.com/elementary/calculator")
    (synopsis "Desktop calculator")
    (description "Calculator is an application for performing simple
arithmetic.  It is the default calculator application in the Pantheon
desktop.")
    (license license:gpl3)))
