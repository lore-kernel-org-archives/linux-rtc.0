Return-Path: <rtc-linux+bncBD2OLRXW4ABBBAHU3C2AKGQEOH7O22Q@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id 190si97632pfb.1.2016.01.13.03.50.24
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2016 03:50:24 -0800 (PST)
Message-ID: <5696378B.6070704@nvidia.com>
Date: Wed, 13 Jan 2016 17:09:55 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <lee.jones@linaro.org>,
	<broonie@kernel.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>
CC: <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<rtc-linux@googlegroups.com>, <swarren@nvidia.com>, <treding@nvidia.com>,
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: [rtc-linux] Re: [PATCH V2 6/6] regulator: max77620: add regulator
 driver for max77620/max20024
References: <1452590273-16421-1-git-send-email-ldewangan@nvidia.com> <1452590273-16421-7-git-send-email-ldewangan@nvidia.com> <5695A854.60108@samsung.com>
In-Reply-To: <5695A854.60108@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


On Wednesday 13 January 2016 06:58 AM, Krzysztof Kozlowski wrote:
> On 12.01.2016 18:17, Laxman Dewangan wrote:
> +
> +	ret = of_regulator_match(&pdev->dev, np, max77620_regulator_matches,
> +			ARRAY_SIZE(max77620_regulator_matches));
> Why not using 'regulators_node' and getting rid of this and some code
> below? If you need to parse custom regulator properties use 'of_parse_cb'.
>

Yaah, this is something new and I think Mark also wanted to do this 
cleanup on his comment. I did not understand it previously. Looks cool now.

However, I have requirement to configure PMIC with some inital setting 
based on init_data (parsed) before regulator registration happened. Once 
I move to this new mecahinsm, the inti_data parsing and regulator init 
happen in the same function. So I need to have one callback from 
regulator_register to driver.
Something below. This will do the pre configuration before 
regulator_register happena dn machine constraint sets.

I can not use the init_data->regulator_init() as I need to have the init 
data passed to the driver.

Created sample patch below.

ldewangan@ldewanganubuntu-System-Product-Name:~/upstream/linux-next/linux-next/drivers/regulator$ 
git diff core.c ../../include/linux/regulator/driver.h
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3308c6b..aa2ca20 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3899,6 +3899,17 @@ regulator_register(const struct regulator_desc 
*regulator_desc,
                 rdev->dev.of_node = of_node_get(config->of_node);
         }

+       if (init_data && regulator_desc->pre_register_init) {
+               ret = regulator_desc->pre_register_init(regulator_desc,
+                                       config, init_data);
+               if (ret < 0) {
+                       dev_err(dev, "Pre register failed: %d\n", ret);
+                       kfree(rdev);
+                       kfree(config);
+                       return ERR_PTR(ret);
+               }
+       }
+
         mutex_lock(&regulator_list_mutex);

         mutex_init(&rdev->mutex);
diff --git a/include/linux/regulator/driver.h 
b/include/linux/regulator/driver.h
index 16ac9e1..fd1d989 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -280,6 +280,9 @@ struct regulator_desc {
         int (*of_parse_cb)(struct device_node *,
                             const struct regulator_desc *,
                             struct regulator_config *);
+       int (*pre_register_init)(const struct regulator_desc *,
+                       struct regulator_config *,
+                       struct regulator_init_data *);
         int id;
         bool continuous_voltage_range;
         unsigned n_voltages;

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
