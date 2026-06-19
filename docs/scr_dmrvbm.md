# Documentacao do `scr_dmrvbm`

`scr_dmrvbm` adiciona suporte a modelos 3D no formato `.vbm` no GameMaker. O arquivo do projeto fica em [scripts/scr_dmrvbm/scr_dmrvbm.gml](../scripts/scr_dmrvbm/scr_dmrvbm.gml) e contem a biblioteca `DmrVBM v1.5`.

O fluxo basico e:

1. Criar uma struct de modelo com `VBM_Model_Create()`.
2. Carregar um arquivo `.vbm` com `VBM_Model_Open()`.
3. Desenhar com `VBM_Model_Submit()` ou `VBM_Model_SubmitMesh()`.
4. Liberar memoria com `VBM_Model_Free()` quando o modelo nao for mais usado.

## Arquivo `.vbm`

Coloque o modelo em `datafiles/`. Neste projeto ja existe:

```text
datafiles/models/Collection.vbm
```

No GameMaker, o caminho usado por `buffer_load()` normalmente deve apontar para o arquivo incluido:

```gml
"models/Collection.vbm"
```

## Exemplo minimo

Crie um objeto, por exemplo `obj_vbm_model`, e use os eventos abaixo.

### Create

```gml
model = VBM_Model_Create();

var ok = VBM_Model_Open(model, "models/Collection.vbm");
if (!ok) {
    show_debug_message("Falha ao carregar Collection.vbm");
}
```

### Draw

```gml
var world = matrix_build(
    x, y, 0,      // posicao
    0, 0, 0,      // rotacao x/y/z
    1, 1, 1       // escala
);

VBM_Model_Submit(model, world);

matrix_set(matrix_world, matrix_build_identity());
```

### Clean Up

```gml
VBM_Model_Free(model);
delete model;
```

## Carregamento

### `VBM_Model_Create()`

Cria e retorna a struct vazia do modelo.

```gml
model = VBM_Model_Create();
```

### `VBM_Model_Open(outvbm, filepath, vbm_openflags=0)`

Carrega um `.vbm` a partir de um arquivo.

```gml
var ok = VBM_Model_Open(model, "models/Collection.vbm");
```

Retorno:

- `0`: falhou.
- Valor positivo: carregou com sucesso. Internamente, pode ser `1` ou a quantidade de bytes lidos.

Para imprimir informacoes dos chunks no output:

```gml
VBM_Model_Open(model, "models/Collection.vbm", VBM_OPENFLAGS.PRINTDEBUG);
```

### `VBM_Model_Load(outvbm, file_buffer, offset, size, vbm_openflags=0)`

Carrega o modelo a partir de um buffer ja aberto. Use quando voce precisa controlar o carregamento manualmente.

```gml
var buff = buffer_load("models/Collection.vbm");
if (buff != -1) {
    VBM_Model_Load(model, buff, 0, buffer_get_size(buff));
    buffer_delete(buff);
}
```

## Desenho

### `VBM_Model_Submit(model, matrix, layermask=VBM_LAYERMASKALL, change_drawstate=true, change_shader=false)`

Desenha todos os meshes do modelo que passam pela mascara de layer.

```gml
var world = matrix_build(x, y, z, 0, 0, image_angle, 1, 1, 1);
VBM_Model_Submit(model, world);
```

Parametros importantes:

- `model`: struct criada por `VBM_Model_Create()`.
- `matrix`: matriz de mundo do modelo.
- `layermask`: quais meshes desenhar. Use `VBM_LAYERMASKALL` para todos.
- `change_drawstate`: se `true`, aplica estado de GPU do material, como depth test, culling e blend.
- `change_shader`: se `true`, tenta ativar o shader pelo nome salvo no material.

Exemplo desenhando apenas uma layer:

```gml
var layer_0 = 1 << 0;
VBM_Model_Submit(model, world, layer_0);
```

Depois de desenhar, e boa pratica restaurar a matriz:

```gml
matrix_set(matrix_world, matrix_build_identity());
```

### `VBM_Model_SubmitMesh(model, mesh_index, texture=VBM_SUBMIT_TEXDEFAULT)`

Desenha apenas um mesh especifico. Essa funcao nao altera estado de GPU nem matriz automaticamente, entao voce prepara isso antes.

```gml
matrix_set(matrix_world, world);
VBM_Model_SubmitMesh(model, 0);
matrix_set(matrix_world, matrix_build_identity());
```

Opcoes de textura:

```gml
VBM_Model_SubmitMesh(model, 0);                    // textura padrao do material
VBM_Model_SubmitMesh(model, 0, VBM_SUBMIT_TEXNONE); // sem textura
VBM_Model_SubmitMesh(model, 0, minha_texture);      // texture pointer customizado
```

## Texturas e materiais

O `.vbm` pode trazer texturas embutidas. Durante o carregamento, elas viram sprites temporarios e sao apagadas por `VBM_Model_Free()`.

Funcoes uteis:

```gml
var tex_count = VBM_Model_GetTextureCount(model);
var tex_ptr = VBM_Model_GetTexturePointer(model, 0);
var material = VBM_Model_GetMaterial(model, 0);
```

Para adicionar uma textura a partir de um sprite do GameMaker:

```gml
var tex_index = VBM_Model_AddTextureSprite(model, spr_minha_textura, false);
var mat_index = VBM_Model_AddMaterial(model, "mat_custom", "", tex_index);
VBM_Model_MeshSetMaterial(model, 0, mat_index);
```

Flags de material principais:

```gml
VBM_MATERIALFLAG.TRANSPARENT
VBM_MATERIALFLAG.USECULLING
VBM_MATERIALFLAG.USEDEPTH
```

Flags de textura principais:

```gml
VBM_MATERIALTEXTUREFLAG.FILTERLINEAR
VBM_MATERIALTEXTUREFLAG.EXTEND
```

## Informacoes do modelo

Algumas funcoes para inspecionar o arquivo carregado:

```gml
show_debug_message("Vertices: " + string(VBM_Model_GetVertexCount(model)));
show_debug_message("Meshes: " + string(VBM_Model_GetMeshdefCount(model)));
show_debug_message("Bones: " + string(VBM_Model_GetBoneCount(model)));
show_debug_message("Texturas: " + string(VBM_Model_GetTextureCount(model)));
show_debug_message("Animacoes: " + string(VBM_Model_GetAnimationCount(model)));
```

Para listar nomes de meshes:

```gml
var mesh_count = VBM_Model_GetMeshdefCount(model);
for (var i = 0; i < mesh_count; i++) {
    show_debug_message(string(i) + ": " + VBM_Model_GetMeshdefName(model, i));
}
```

Para listar bones:

```gml
VBM_Model_PrintBoneTree(model);
```

## Animacoes

O modelo pode conter animacoes exportadas no `.vbm`.

### Buscar animacao

```gml
anim = VBM_Model_GetAnimation(model, 0);
// ou:
anim = VBM_Model_FindAnimation(model, "Walk");
```

### Avancar frame

```gml
anim_frame += 1;
anim_frame = VBM_ModelAnimation_EvaluateFrame(anim, anim_frame);
```

### Avaliar matrices de skinning

Para modelos com bones, crie arrays uma vez e atualize no Step ou Draw.

```gml
var bone_count = VBM_Model_GetBoneCount(model);
skin_matrices = vbm_mat4_identity_array_1d(bone_count);
```

Depois:

```gml
VBM_Model_EvaluateAnimationEasy(model, anim, anim_frame, skin_matrices);
```

Importante: `VBM_Model_EvaluateAnimationEasy()` so calcula as matrizes. Para deformar vertices na GPU, voce ainda precisa de um shader que receba essas matrizes e use os atributos de bone/weight do vertex format. O `VBM_Model_Submit()` padrao desenha o vertex buffer, mas nao envia automaticamente o array de bones para um shader.

## Raycast em prismas

Se o `.vbm` tiver prismas exportados, use `VBM_Model_CastRay()` para testar intersecao.

```gml
var hit_pos = [0, 0, 0];
var hit_normal = [0, 0, 0];

var dist = VBM_Model_CastRay(
    model,
    matrix_build_identity(),
    px, py, pz,
    dx, dy, dz,
    0,
    1000,
    VBM_LAYERMASKALL,
    VBM_LAYERMASKALL,
    hit_pos,
    hit_normal
);

if (!is_undefined(dist)) {
    show_debug_message("Hit em distancia " + string(dist));
}
```

## Liberacao de recursos

Sempre chame `VBM_Model_Free()` quando terminar de usar o modelo.

```gml
if (is_struct(model)) {
    VBM_Model_Free(model);
    delete model;
}
```

Isso libera:

- vertex buffer;
- vertex format;
- sprites de textura criados pelo loader;
- animcurves das animacoes;
- structs internas de meshes, bones, materiais, texturas, prismas e animacoes.

## Cuidados no script atual

- `VBM_Model_Submit()` e descrito no proprio codigo como um metodo simples/cru de renderizacao. Para muitos modelos, crie um renderer que agrupe materiais e reduza trocas de shader/textura.
- `VBM_Model_Submit()` so muda shader se `change_shader` for `true`.
- `VBM_Model_SubmitMesh()` nao altera draw state. Configure matriz, shader, depth, culling e blend antes de chamar.
- `VBM_Model_GetMaterialCount()` no script atual usa `model.material`, mas a struct se chama `model.materials`. Se precisar da contagem, use temporariamente `array_length(model.materials)` ou corrija a funcao.
- `VBM_Model_AddTextureSprite()` tem uma linha suspeita: `texture |= VBM_TEXTUREFLAG.FREEONDELETE;`. O esperado seria alterar `texture.flags`. Evite `free_on_delete=true` ate corrigir isso.

