(define-module (planner)
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
         "1csxsr2c8qvl97xz9ahwn91z095nzgr0i1mbcb1spljll2sr9lkj"))))
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
     `(("granite" ,granite)
       ("glib" ,glib)
       ("gtk" ,gtk+)
       ("libgee" ,libgee)))
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
