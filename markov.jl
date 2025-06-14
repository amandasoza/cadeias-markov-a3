function prever_estado_markov(matriz_transicao::Matrix{Float64}, estado_inicial::Vector{Float64}, passos::Int)
    #Validação da matriz e do vetor inicial
    n, m = size(matriz_transicao)
    @assert n == m "A matriz de transição deve ser quadrada."
    @assert length(estado_inicial) == n "O vetor de estado inicial deve ter o mesmo tamanho que a matriz de transição."
    @assert all(abs.(sum(matriz_transicao, dims=2) .- 1) .< 1e-6) "As linhas da matriz de transição devem somar 1."
    @assert abs(sum(estado_inicial) - 1) < 1e-6 "O vetor de estado inicial deve somar 1."

    #Cálculo do estado após o número de passos especificado
    estado_atual = estado_inicial'
    for _ in 1:passos
        estado_atual = estado_atual * matriz_transicao
    end

    return estado_atual'
end

function main()
    println("Informe o tamanho da matriz de transição (número de estados):")
    tamanho_matriz = parse(Int, readline())

    println("Informe a matriz de transição ($tamanho_matriz x $tamanho_matriz):")
    matriz_transicao = Matrix{Float64}(undef, tamanho_matriz, tamanho_matriz)
    for i in 1:tamanho_matriz
        println("Informe os elementos da linha $i, separados por espaços:")
        matriz_transicao[i, :] = parse.(Float64, split(readline()))
    end

    println("Informe o vetor de estado inicial (tamanho $tamanho_matriz):")
    estado_inicial = parse.(Float64, split(readline()))

    println("Informe o número de passos:")
    passos = parse(Int, readline())

    estado_previsto = prever_estado_markov(matriz_transicao, estado_inicial, passos)
    println("Distribuição de probabilidades após $passos passos: $estado_previsto")
end

main()