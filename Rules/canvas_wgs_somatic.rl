rule canvas_wgs_somatic:
    input: normal=lambda wildcards: config['project']['pairs'][wildcards.x][0]+".recal.bam",
           tumor=lambda wildcards: config['project']['pairs'][wildcards.x][1]+".recal.bam",
           somaticvcf=config['project']['workpath']+"/mutect2_out/{x}.FINALmutect2.vcf",
           bvcf=config['project']['workpath']+"/cnvkit_out/{x}_filtGermpairs.vcf",
    output: tumorvcf="canvas_out/{x}/tumor_CNV.vcf.gz",
            normvcf="canvas_out/{x}/normal_CNV.vcf.gz",
    params: genome=config['references'][pfamily]['CANVASGENOME'],tumorsample=lambda wildcards: config['project']['pairs'][wildcards.x][1],normalsample=lambda wildcards: config['project']['pairs'][wildcards.x][0],kmer=config['references'][pfamily]['CANVASKMER'],filter=config['references'][pfamily]['CANVASFILTER'],balleles=config['references'][pfamily]['KNOWNVCF2'],rname="pl:canvas"
    shell: "mkdir -p canvas_out; mkdir -p canvas_out/{params.normalsample}+{params.tumorsample}/{params.tumorsample}; cp {params.tumorsample}.recal.bai {params.tumorsample}.recal.bam.bai; cp {params.normalsample}.recal.bai {params.normalsample}.recal.bam.bai; mkdir -p canvas_out/{params.normalsample}+{params.tumorsample}/{params.normalsample}; export COMPlus_gcAllowVeryLargeObjects=1; module load Canvas/1.31; Canvas.dll Somatic-WGS -b {input.tumor} -o canvas_out/{params.normalsample}+{params.tumorsample}/{params.tumorsample} -r {params.kmer} -g {params.genome} -f {params.filter} --sample-name={params.tumorsample} --population-b-allele-vcf={params.balleles} --somatic-vcf={input.somaticvcf}; module load vcftools; vcftools --vcf {input.bvcf} --indv {params.normalsample} --recode --recode-INFO-all --out canvas_out/{params.normalsample}+{params.tumorsample}/{params.normalsample}/{params.normalsample}; Canvas.dll Germline-WGS -b {input.normal} -o canvas_out/{params.normalsample}+{params.tumorsample}/{params.normalsample} -r {params.kmer} -g {params.genome} -f {params.filter} --sample-name={params.normalsample} --sample-b-allele-vcf=canvas_out/{params.normalsample}+{params.tumorsample}/{params.normalsample}/{params.normalsample}.recode.vcf; mv canvas_out/{params.normalsample}+{params.tumorsample}/{params.tumorsample}/CNV.vcf.gz canvas_out/{params.normalsample}+{params.tumorsample}/tumor_CNV.vcf.gz; mv canvas_out/{params.normalsample}+{params.tumorsample}/{params.normalsample}/CNV.vcf.gz canvas_out/{params.normalsample}+{params.tumorsample}/normal_CNV.vcf.gz"