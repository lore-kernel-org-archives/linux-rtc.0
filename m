Return-Path: <rtc-linux+bncBDJ4N37Q6EERBXPV7XBAKGQEJVJYQ2Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mga09.intel.com (mga09.intel.com. [134.134.136.24])
        by gmr-mx.google.com with ESMTPS id w2si10731430pfg.0.2016.12.24.23.53.01
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Dec 2016 23:53:01 -0800 (PST)
Date: Sun, 25 Dec 2016 15:51:59 +0800
From: kbuild test robot <lkp@intel.com>
To: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Cc: kbuild-all@01.org, alexandre.belloni@free-electrons.com,
	manabian@gmail.com, a.zummo@towertech.it,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
	Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: add support for rtc NXP pca21125 and pca8565
Message-ID: <201612251526.9Ik1WOmO%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
In-Reply-To: <1482649088-2845-1-git-send-email-venkat.prashanth2498@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Venkat,

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on v4.9 next-20161224]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Venkat-Prashanth-B-U/rtc-add-support-for-rtc-NXP-pca21125-and-pca8565/20161225-150140
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: i386-randconfig-x016-201652 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/rtc/rtc-pcf8563.c:26:0:
   drivers/rtc/rtc-pcf8563.c: In function 'pca21125_probe':
>> drivers/rtc/rtc-pcf8563.c:666:32: warning: passing argument 1 of '__devm_regmap_init_spi' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     regmap = devm_regmap_init_spi(spi, &config);
                                   ^
   include/linux/regmap.h:505:6: note: in definition of macro '__regmap_lockdep_wrapper'
      fn(__VA_ARGS__, &_key,     \
         ^~~~~~~~~~~
>> drivers/rtc/rtc-pcf8563.c:666:11: note: in expansion of macro 'devm_regmap_init_spi'
     regmap = devm_regmap_init_spi(spi, &config);
              ^~~~~~~~~~~~~~~~~~~~
   include/linux/regmap.h:470:16: note: expected 'struct spi_device *' but argument is of type 'const struct spi_device *'
    struct regmap *__devm_regmap_init_spi(struct spi_device *dev,
                   ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/rtc/rtc-pcf8563.c:674:12: error: assignment of member 'mode' in read-only object
     spi->mode = SPI_MODE_3;
               ^
>> drivers/rtc/rtc-pcf8563.c:675:21: error: assignment of member 'bits_per_word' in read-only object
     spi->bits_per_word = 8;
                        ^
>> drivers/rtc/rtc-pcf8563.c:676:12: warning: passing argument 1 of 'spi_setup' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     spi_setup(spi);
               ^~~
   In file included from drivers/rtc/rtc-pcf8563.c:25:0:
   include/linux/spi/spi.h:905:12: note: expected 'struct spi_device *' but argument is of type 'const struct spi_device *'
    extern int spi_setup(struct spi_device *spi);
               ^~~~~~~~~
>> drivers/rtc/rtc-pcf8563.c:678:20: warning: passing argument 1 of 'regmap_read' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     res = regmap_read(regmap, PCF8563_REG_SC, &tmp);
                       ^~~~~~
   In file included from drivers/rtc/rtc-pcf8563.c:26:0:
   include/linux/regmap.h:758:5: note: expected 'struct regmap *' but argument is of type 'const struct regmap *'
    int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
        ^~~~~~~~~~~
   drivers/rtc/rtc-pcf8563.c:682:20: warning: passing argument 1 of 'regmap_read' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     res = regmap_read(regmap, PCF8563_REG_CLKO, &tmp);
                       ^~~~~~
   In file included from drivers/rtc/rtc-pcf8563.c:26:0:
   include/linux/regmap.h:758:5: note: expected 'struct regmap *' but argument is of type 'const struct regmap *'
    int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
        ^~~~~~~~~~~
>> drivers/rtc/rtc-pcf8563.c:687:21: warning: passing argument 1 of 'regmap_write' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     res = regmap_write(regmap, PCF8563_REG_CLKO, tmp & 0x1c);
                        ^~~~~~
   In file included from drivers/rtc/rtc-pcf8563.c:26:0:
   include/linux/regmap.h:745:5: note: expected 'struct regmap *' but argument is of type 'const struct regmap *'
    int regmap_write(struct regmap *map, unsigned int reg, unsigned int val);
        ^~~~~~~~~~~~
   drivers/rtc/rtc-pcf8563.c:692:20: warning: passing argument 1 of 'regmap_read' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     res = regmap_read(regmap, PCF8563_REG_SR, &tmp);
                       ^~~~~~
   In file included from drivers/rtc/rtc-pcf8563.c:26:0:
   include/linux/regmap.h:758:5: note: expected 'struct regmap *' but argument is of type 'const struct regmap *'
    int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
        ^~~~~~~~~~~
   drivers/rtc/rtc-pcf8563.c:697:21: warning: passing argument 1 of 'regmap_write' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     res = regmap_write(regmap, PCF8563_REG_SR, tmp & 0x88);
                        ^~~~~~
   In file included from drivers/rtc/rtc-pcf8563.c:26:0:
   include/linux/regmap.h:745:5: note: expected 'struct regmap *' but argument is of type 'const struct regmap *'
    int regmap_write(struct regmap *map, unsigned int reg, unsigned int val);
        ^~~~~~~~~~~~
   drivers/rtc/rtc-pcf8563.c:703:20: warning: passing argument 1 of 'regmap_read' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     res = regmap_read(regmap, PCF8563_REG_CLKO, &tmp);
                       ^~~~~~
   In file included from drivers/rtc/rtc-pcf8563.c:26:0:
   include/linux/regmap.h:758:5: note: expected 'struct regmap *' but argument is of type 'const struct regmap *'
    int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
        ^~~~~~~~~~~
   drivers/rtc/rtc-pcf8563.c:709:20: warning: passing argument 1 of 'regmap_read' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     res = regmap_read(regmap, PCF8563_REG_SR, &tmp);
                       ^~~~~~
   In file included from drivers/rtc/rtc-pcf8563.c:26:0:
   include/linux/regmap.h:758:5: note: expected 'struct regmap *' but argument is of type 'const struct regmap *'
    int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val);
        ^~~~~~~~~~~
>> drivers/rtc/rtc-pcf8563.c:716:42: warning: passing argument 1 of 'devm_rtc_device_register' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     pcf8563->rtc = devm_rtc_device_register(&spi->dev,
                                             ^
   In file included from drivers/rtc/rtc-pcf8563.c:20:0:
   include/linux/rtc.h:163:27: note: expected 'struct device *' but argument is of type 'const struct device *'
    extern struct rtc_device *devm_rtc_device_register(struct device *dev,
                              ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/rtc/rtc-pcf8563.c:716:15: error: assignment of member 'rtc' in read-only object
     pcf8563->rtc = devm_rtc_device_register(&spi->dev,
                  ^
   drivers/rtc/rtc-pcf8563.c: At top level:
>> drivers/rtc/rtc-pcf8563.c:726:1: error: expected expression before 'static'
    static struct i2c_driver pcf8563_driver = {
    ^~~~~~
>> drivers/rtc/rtc-pcf8563.c:726:1: warning: excess elements in struct initializer
   drivers/rtc/rtc-pcf8563.c:726:1: note: (near initialization for 'pca21125_driver')
>> drivers/rtc/rtc-pcf8563.c:652:0: error: unterminated #if
    #if IS_ENABLED(CONFIG_SPI_MASTER)
    
   drivers/rtc/rtc-pcf8563.c:654:12: warning: 'pca21125_probe' defined but not used [-Wunused-function]
    static int pca21125_probe(const struct spi_device *spi)
               ^~~~~~~~~~~~~~
   drivers/rtc/rtc-pcf8563.c:566:12: warning: 'pcf8563_probe' defined but not used [-Wunused-function]
    static int pcf8563_probe(struct i2c_client *client,
               ^~~~~~~~~~~~~

vim +/mode +674 drivers/rtc/rtc-pcf8563.c

   646		{ .compatible = "nxp,pca8565" },
   647		{}
   648	};
   649	MODULE_DEVICE_TABLE(of, pcf8563_of_match);
   650	#endif
   651	
 > 652	#if IS_ENABLED(CONFIG_SPI_MASTER)
   653	
   654	static int pca21125_probe(const struct spi_device *spi)
   655	{
   656		int res;
   657		unsigned int tmp;
   658		static const struct regmap_config config = {
   659					.reg_bits = 8,
   660					.val_bits = 8,
   661					.write_flag_mask = 0x80,
   662			};
   663	const struct regmap *regmap;
   664	const struct pcf8563 *pcf8563;
   665	
 > 666		regmap = devm_regmap_init_spi(spi, &config);
   667	
   668				if (IS_ERR(regmap)) {
   669					dev_err(&spi->dev, "%s: regmap allocation failed: %ld\n",
   670						__func__, PTR_ERR(regmap));
   671					return PTR_ERR(regmap);
   672			}
   673	
 > 674		spi->mode = SPI_MODE_3;
 > 675		spi->bits_per_word = 8;
 > 676		spi_setup(spi);
   677	
 > 678		res = regmap_read(regmap, PCF8563_REG_SC, &tmp);
   679	
   680		if (res)
   681			return res;
 > 682		res = regmap_read(regmap, PCF8563_REG_CLKO, &tmp);
   683	
   684		if (res)
   685			return res;
   686	
 > 687		res = regmap_write(regmap, PCF8563_REG_CLKO, tmp & 0x1c);
   688	
   689		if (res)
   690			return res;
   691	
   692		res = regmap_read(regmap, PCF8563_REG_SR, &tmp);
   693	
   694		if (res)
   695			return res;
   696	
   697		res = regmap_write(regmap, PCF8563_REG_SR, tmp & 0x88);
   698	
   699		if (res)
   700			return res;
   701	
   702	       /* Print our settings */
   703		res = regmap_read(regmap, PCF8563_REG_CLKO, &tmp);
   704	
   705		if (res)
   706			return res;
   707	
   708		dev_info(&spi->dev, "Control Reg: 0x%02x\n", tmp);
 > 709		res = regmap_read(regmap, PCF8563_REG_SR, &tmp);
   710	
   711		if (res)
   712			return res;
   713	
   714		dev_info(&spi->dev, "Ctrl/Stat Reg: 0x%02x\n", tmp);
   715	
 > 716		pcf8563->rtc = devm_rtc_device_register(&spi->dev,
   717									"pcf8563",
   718							&pcf8563_rtc_ops, THIS_MODULE);
   719	}
   720	
   721	const struct spi_driver pca21125_driver = {
   722			.driver = {
   723					.name    = "pca21125",
   724			},
   725	
 > 726	static struct i2c_driver pcf8563_driver = {
   727		.driver		= {
   728			.name	= "rtc-pcf8563",
   729			.of_match_table = of_match_ptr(pcf8563_of_match),

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--HcAYCG3uE/tztfnV
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--HcAYCG3uE/tztfnV--
