if config['project']['annotation'] == "hg19":

  rule all_exomeseq_somatic:
    input:  expand("{s}"+".realign.bam",s=samples),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_1.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_2.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_3.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_4.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_5.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_6.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_7.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_8.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_9.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_10.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_11.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_12.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_13.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_14.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_15.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_16.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_17.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_18.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_19.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_20.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_21.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_22.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_X.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_Y.vcf",p=pairs),
#            expand("mutect2_out/chrom_files/{p}_{chr}.vcf",p=pairs,chr=config['references'][pfamily]['CHROMS']),
            expand(config['project']['workpath']+"/mutect_out/{p}"+".FINAL.vcf",p=pairs),
            expand(config['project']['workpath']+"/strelka_out/{p}"+".vcf",p=pairs),
#            expand(config['project']['workpath']+"/mutect2_out/oncotator_out/{p}"+".maf",p=pairs),
            expand(config['project']['workpath']+"/strelka_out/oncotator_out/{p}"+".maf",p=pairs),
            expand(config['project']['workpath']+"/mutect_out/oncotator_out/{p}"+".maf",p=pairs),
            config['project']['workpath']+"/mutect_variants_alview.input",
            config['project']['workpath']+"/strelka_out",
            config['project']['workpath']+"/mutect2_out",
            config['project']['workpath']+"/cnvkit_out",
            config['project']['workpath']+"/mutect_out",
            config['project']['workpath']+"/delly_out",
            expand(config['project']['workpath']+"/cnvkit_out/{p}_calls.cns", p=pairs),
            expand(config['project']['workpath']+"/cnvkit_out/{p}_gainloss.tsv", p=pairs),                        
            expand(config['project']['workpath']+"/delly_out/{p}_del.bcf", p=pairs),
            expand(config['project']['workpath']+"/delly_out/{p}_ins.bcf", p=pairs),
            expand(config['project']['workpath']+"/delly_out/{p}_dup.bcf", p=pairs),
            expand(config['project']['workpath']+"/delly_out/{p}_tra.bcf", p=pairs),
            expand(config['project']['workpath']+"/delly_out/{p}_inv.bcf", p=pairs),
            expand(config['project']['workpath']+"/theta_out/{p}/{p}.input", p=pairs),
            expand(config['project']['workpath']+"/conpair_out/{p}.conpair", p=pairs),
            config['project']['workpath']+"/mutect_out/merged_somatic.vcf",
            config['project']['workpath']+"/cnvkit_out/CNVkit_summary_heatmap.pdf",
            config['project']['workpath']+"/mutect_out/merged_somatic_snpEff.vcf",
            config['project']['workpath']+"/strelka_out/merged_somatic_snpEff.vcf",
#            config['project']['workpath']+"/mutect2_out/merged_somatic.vcf",
#            config['project']['workpath']+"/mutect2_out/merged_somatic_snpEff.vcf",
            config['project']['workpath']+"/variants.bed",
            config['project']['workpath']+"/full_annot.txt.zip",
            config['project']['workpath']+"/sample_network.bmp",
            config['project']['workpath']+"/variants.database",
#            config['project']['workpath']+"/mutect2_out/oncotator_out/mutect2_variants.maf",
#            config['project']['workpath']+"/mutect2_out/mutsigCV_out/somatic.sig_genes.txt",
            config['project']['workpath']+"/strelka_out/oncotator_out/strelka_variants.maf",
            config['project']['workpath']+"/strelka_out/mutsigCV_out/somatic.sig_genes.txt",
            config['project']['workpath']+"/mutect_out/oncotator_out/mutect_variants.maf",
            config['project']['workpath']+"/mutect_out/mutsigCV_out/somatic.sig_genes.txt",
            config['project']['workpath']+"/exome_targets.bed"
    output:
    params: rname="final"
    shell:  """
             module load multiqc; multiqc -f -e featureCounts .; mv *.out slurmfiles/; mv *.fin.bam.intervals logfiles/; rm *realign.bai; mv distance.cluster0 distance.cluster1 distance.cluster2 distance.cluster3 distance.nosex samples.txt plink.map plink.ped *.avia_status.txt *.avia.log *_genotypes.vcf logfiles/

            """

else:

  rule all_exomeseq_somatic:
    input:  expand("{s}"+".realign.bam",s=samples),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr1.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr2.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr3.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr4.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr5.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr6.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr7.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr8.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr9.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr10.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr11.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr12.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr13.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr14.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr15.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr16.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr17.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr18.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chr19.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chrX.vcf",p=pairs),
            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_chrY.vcf",p=pairs),
#            expand(config['project']['workpath']+"/mutect2_out/chrom_files/{p}_{chr}.vcf",p=pairs,chr=config['references'][pfamily]['CHROMS']),
            expand(config['project']['workpath']+"/mutect_out/{p}"+".FINAL.vcf",p=pairs),
            expand(config['project']['workpath']+"/strelka_out/{p}"+".vcf",p=pairs),
            config['project']['workpath']+"/mutect_variants_alview.input",
            config['project']['workpath']+"/strelka_out",
            config['project']['workpath']+"/mutect2_out",
            config['project']['workpath']+"/cnvkit_out",
            config['project']['workpath']+"/mutect_out",
            config['project']['workpath']+"/delly_out",
            expand(config['project']['workpath']+"/cnvkit_out/{p}_calls.cns", p=pairs),
            expand(config['project']['workpath']+"/cnvkit_out/{p}_gainloss.tsv", p=pairs),                        
            expand(config['project']['workpath']+"/delly_out/{p}_del.bcf", p=pairs),
            expand(config['project']['workpath']+"/delly_out/{p}_ins.bcf", p=pairs),
            expand(config['project']['workpath']+"/delly_out/{p}_dup.bcf", p=pairs),
            expand(config['project']['workpath']+"/delly_out/{p}_tra.bcf", p=pairs),
            expand(config['project']['workpath']+"/delly_out/{p}_inv.bcf", p=pairs),
            expand(config['project']['workpath']+"/theta_out/{p}/{p}.input", p=pairs),
            expand(config['project']['workpath']+"/conpair_out/{p}.conpair", p=pairs),
            config['project']['workpath']+"/mutect_out/merged_somatic.vcf",
            config['project']['workpath']+"/cnvkit_out/CNVkit_summary_heatmap.pdf",
            config['project']['workpath']+"/mutect_out/merged_somatic_snpEff.vcf",
            config['project']['workpath']+"/strelka_out/merged_somatic_snpEff.vcf",
#            config['project']['workpath']+"/mutect2_out/merged_somatic.vcf",
#            config['project']['workpath']+"/mutect2_out/merged_somatic_snpEff.vcf",
            config['project']['workpath']+"/variants.bed",
            config['project']['workpath']+"/full_annot.txt.zip",
            config['project']['workpath']+"/sample_network.bmp",
            config['project']['workpath']+"/variants.database",
            config['project']['workpath']+"/exome_targets.bed"
    output:
    params: rname="final"
    shell:  """
             module load multiqc; multiqc -f -e featureCounts .; mv *.out slurmfiles/; mv *.fin.bam.intervals logfiles/; rm *realign.bai; mv distance.cluster0 distance.cluster1 distance.cluster2 distance.cluster3 distance.nosex samples.txt plink.map plink.ped *.avia_status.txt *.avia.log *_genotypes.vcf logfiles/

            """