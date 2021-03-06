//
//  MIMEType.swift
//  UNIXFileSystem
//
//  Created by Meniny on 21/09/2016.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

fileprivate let DEFAULT_MIME_TYPE = "application/octet-stream"
public enum UFSFileExtension: String {
    case html = "html"
    case htm = "htm"
    case shtml = "shtml"
    case css = "css"
    case xml = "xml"
    case gif = "gif"
    case jpeg = "jpeg"
    case jpg = "jpg"
    case js = "js"
    case atom = "atom"
    case rss = "rss"
    case mml = "mml"
    case txt = "txt"
    case jad = "jad"
    case wml = "wml"
    case htc = "htc"
    case png = "png"
    case tif = "tif"
    case tiff = "tiff"
    case wbmp = "wbmp"
    case ico = "ico"
    case jng = "jng"
    case bmp = "bmp"
    case svg = "svg"
    case svgz = "svgz"
    case webp = "webp"
    case woff = "woff"
    case jar = "jar"
    case war = "war"
    case ear = "ear"
    case json = "json"
    case hqx = "hqx"
    case doc = "doc"
    case pdf = "pdf"
    case ps = "ps"
    case eps = "eps"
    case ai = "ai"
    case rtf = "rtf"
    case m3u8 = "m3u8"
    case xls = "xls"
    case eot = "eot"
    case ppt = "ppt"
    case wmlc = "wmlc"
    case kml = "kml"
    case kmz = "kmz"
    case sevenz = "7z"
    case cco = "cco"
    case jardiff = "jardiff"
    case jnlp = "jnlp"
    case run = "run"
    case pl = "pl"
    case pm = "pm"
    case prc = "prc"
    case pdb = "pdb"
    case rar = "rar"
    case rpm = "rpm"
    case sea = "sea"
    case swf = "swf"
    case sit = "sit"
    case tcl = "tcl"
    case tk = "tk"
    case der = "der"
    case pem = "pem"
    case crt = "crt"
    case xpi = "xpi"
    case xhtml = "xhtml"
    case xspf = "xspf"
    case zip = "zip"
    case bin = "bin"
    case exe = "exe"
    case dll = "dll"
    case deb = "deb"
    case dmg = "dmg"
    case iso = "iso"
    case img = "img"
    case msi = "msi"
    case msp = "msp"
    case msm = "msm"
    case docx = "docx"
    case xlsx = "xlsx"
    case pptx = "pptx"
    case mid = "mid"
    case midi = "midi"
    case kar = "kar"
    case mp3 = "mp3"
    case ogg = "ogg"
    case m4a = "m4a"
    case ra = "ra"
    case threegpp = "3gpp"
    case threegp = "3gp"
    case ts = "ts"
    case mp4 = "mp4"
    case mpeg = "mpeg"
    case mpg = "mpg"
    case mov = "mov"
    case webm = "webm"
    case flv = "flv"
    case m4v = "m4v"
    case mng = "mng"
    case asx = "asx"
    case asf = "asf"
    case wmv = "wmv"
    case avi = "avi"
    
    public var mimeType: String {
        switch self {
        case .html: return "text/html"
        case .htm: return "text/html"
        case .shtml: return "text/html"
        case .css: return "text/css"
        case .xml: return "text/xml"
        case .gif: return "image/gif"
        case .jpeg: return "image/jpeg"
        case .jpg: return "image/jpeg"
        case .js: return "application/javascript"
        case .atom: return "application/atom+xml"
        case .rss: return "application/rss+xml"
        case .mml: return "text/mathml"
        case .txt: return "text/plain"
        case .jad: return "text/vnd.sun.j2me.app-descriptor"
        case .wml: return "text/vnd.wap.wml"
        case .htc: return "text/x-component"
        case .png: return "image/png"
        case .tif: return "image/tiff"
        case .tiff: return "image/tiff"
        case .wbmp: return "image/vnd.wap.wbmp"
        case .ico: return "image/x-icon"
        case .jng: return "image/x-jng"
        case .bmp: return "image/x-ms-bmp"
        case .svg: return "image/svg+xml"
        case .svgz: return "image/svg+xml"
        case .webp: return "image/webp"
        case .woff: return "application/font-woff"
        case .jar: return "application/java-archive"
        case .war: return "application/java-archive"
        case .ear: return "application/java-archive"
        case .json: return "application/json"
        case .hqx: return "application/mac-binhex40"
        case .doc: return "application/msword"
        case .pdf: return "application/pdf"
        case .ps: return "application/postscript"
        case .eps: return "application/postscript"
        case .ai: return "application/postscript"
        case .rtf: return "application/rtf"
        case .m3u8: return "application/vnd.apple.mpegurl"
        case .xls: return "application/vnd.ms-excel"
        case .eot: return "application/vnd.ms-fontobject"
        case .ppt: return "application/vnd.ms-powerpoint"
        case .wmlc: return "application/vnd.wap.wmlc"
        case .kml: return "application/vnd.google-earth.kml+xml"
        case .kmz: return "application/vnd.google-earth.kmz"
        case .sevenz: return "application/x-7z-compressed"
        case .cco: return "application/x-cocoa"
        case .jardiff: return "application/x-java-archive-diff"
        case .jnlp: return "application/x-java-jnlp-file"
        case .run: return "application/x-makeself"
        case .pl: return "application/x-perl"
        case .pm: return "application/x-perl"
        case .prc: return "application/x-pilot"
        case .pdb: return "application/x-pilot"
        case .rar: return "application/x-rar-compressed"
        case .rpm: return "application/x-redhat-package-manager"
        case .sea: return "application/x-sea"
        case .swf: return "application/x-shockwave-flash"
        case .sit: return "application/x-stuffit"
        case .tcl: return "application/x-tcl"
        case .tk: return "application/x-tcl"
        case .der: return "application/x-x509-ca-cert"
        case .pem: return "application/x-x509-ca-cert"
        case .crt: return "application/x-x509-ca-cert"
        case .xpi: return "application/x-xpinstall"
        case .xhtml: return "application/xhtml+xml"
        case .xspf: return "application/xspf+xml"
        case .zip: return "application/zip"
        case .bin: return "application/octet-stream"
        case .exe: return "application/octet-stream"
        case .dll: return "application/octet-stream"
        case .deb: return "application/octet-stream"
        case .dmg: return "application/octet-stream"
        case .iso: return "application/octet-stream"
        case .img: return "application/octet-stream"
        case .msi: return "application/octet-stream"
        case .msp: return "application/octet-stream"
        case .msm: return "application/octet-stream"
        case .docx: return "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        case .xlsx: return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        case .pptx: return "application/vnd.openxmlformats-officedocument.presentationml.presentation"
        case .mid: return "audio/midi"
        case .midi: return "audio/midi"
        case .kar: return "audio/midi"
        case .mp3: return "audio/mpeg"
        case .ogg: return "audio/ogg"
        case .m4a: return "audio/x-m4a"
        case .ra: return "audio/x-realaudio"
        case .threegpp: return "video/3gpp"
        case .threegp: return "video/3gpp"
        case .ts: return "video/mp2t"
        case .mp4: return "video/mp4"
        case .mpeg: return "video/mpeg"
        case .mpg: return "video/mpeg"
        case .mov: return "video/quicktime"
        case .webm: return "video/webm"
        case .flv: return "video/x-flv"
        case .m4v: return "video/x-m4v"
        case .mng: return "video/x-mng"
        case .asx: return "video/x-ms-asf"
        case .asf: return "video/x-ms-asf"
        case .wmv: return "video/x-ms-wmv"
        case .avi: return "video/x-msvideo"
        }
    }
}

public extension UFSFile {
    var mimeType: String {
        return UFSFileExtension.init(rawValue: self.path.pathExtension)?.mimeType ?? DEFAULT_MIME_TYPE
    }
}
