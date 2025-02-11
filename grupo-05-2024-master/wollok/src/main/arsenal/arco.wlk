class Arco {
    var tension = 40
    const longitud

    method tension(unaTension) {
      tension = unaTension
    }
    method poderDeArma() = (tension * longitud) / 10
}
