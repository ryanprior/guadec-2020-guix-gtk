(define-module (planner)
  #:use-module (gnu packages calendar)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages pantheon)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages)
  #:use-module (guix build-system meson)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) :prefix license:)
  #:use-module (guix packages)
  #:use-module (guix utils))

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
