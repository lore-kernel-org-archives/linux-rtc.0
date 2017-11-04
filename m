Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52803 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbdKDQIh (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 4 Nov 2017 12:08:37 -0400
Date: Sat, 4 Nov 2017 17:08:36 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Eric Nelson <eric@nelint.com>
Cc: linux-rtc@vger.kernel.org, robh@kernel.org, a.zummo@towertech.it,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        otavio.salvador@ossystems.com.br
Subject: Re: [PATCH V3] rtc: add support for NXP PCF85363 real-time clock
Message-ID: <20171104160836.bah5su2ld5ckycr3@piout.net>
References: <CAL_Jsq+QQK=NTMBwk=h0uszLW0uSiEd1fmF09USRNFM-2VgiSQ@mail.gmail.com>
 <1509548480-29472-1-git-send-email-eric@nelint.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1509548480-29472-1-git-send-email-eric@nelint.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 01/11/2017 at 08:01:20 -0700, Eric Nelson wrote:
> Note that alarms are not currently implemented.
> 
> 64 bytes of nvmem is supported and exposed in
> sysfs (# is the instance number, starting with 0):
> 
> 	/sys/bus/nvmem/devices/pcf85363-#/nvmem
> 
> Signed-off-by: Eric Nelson <eric@nelint.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> V2 addresses a couple of issues highlighted by Fabio Estevam
>     1. Kconfig updated to select REGMAP_I2C
>     2. Switch to of_device_id from i2c_device_id for driver matching
> 
> V3 adds interrupts as an optional property in device tree bindings
> 
>  drivers/rtc/Kconfig                                |  13 ++
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-pcf85363.c                         | 221 +++++++++++++++++++++
>  4 files changed, 252 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/pcf85363.txt
>  create mode 100644 drivers/rtc/rtc-pcf85363.c
> 

I've tested it (thanks to Fabio, I received one a few weeks ago)

Applied with the following change:

--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -194,7 +194,6 @@ static int pcf85363_probe(struct i2c_client *client,
        pcf85363->nvmem_cfg.reg_write = pcf85363_nvram_write;
        pcf85363->nvmem_cfg.priv = pcf85363;
        pcf85363->rtc->nvmem_config = &pcf85363->nvmem_cfg;
-       pcf85363->rtc->nvram_old_abi = true;
        pcf85363->rtc->ops = &rtc_ops;
 
        return rtc_register_device(pcf85363->rtc);


nvram_old_abi must not be used for new drivers and will generate warning
when the (undocumented) ABI is used anyway.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
