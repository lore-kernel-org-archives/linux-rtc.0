Return-Path: <rtc-linux+bncBD2OLRXW4ABBBWUBX22AKGQEXC7X2OY@googlegroups.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com. [216.228.121.65])
        by gmr-mx.google.com with ESMTPS id h86si192364pfd.0.2016.01.08.01.26.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2016 01:26:49 -0800 (PST)
Message-ID: <568F7E7B.1010501@nvidia.com>
Date: Fri, 8 Jan 2016 14:46:43 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	<rtc-linux@googlegroups.com>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linus.walleij@linaro.org>, <gnurou@gmail.com>, <lee.jones@linaro.org>,
	<broonie@kernel.org>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>, <lgirdwood@gmail.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <swarren@nvidia.com>, <treding@nvidia.com>,
	Chaitanya Bandi <bandik@nvidia.com>, Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: Re: [rtc-linux] [PATCH 2/6] mfd: max77620: add core driver for MAX77620/MAX20024
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com>	<1452177524-23192-3-git-send-email-ldewangan@nvidia.com> <CAJKOXPfa0jjRWE6LKvNmwCRcG9Es7=36_03kTqCx-aB1wENx0g@mail.gmail.com>
In-Reply-To: <CAJKOXPfa0jjRWE6LKvNmwCRcG9Es7=36_03kTqCx-aB1wENx0g@mail.gmail.com>
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

Hi Krzysztof,
Thanks for review.
I will fix most of your comment on my next patch.

Answering to some of comment/query.

On Friday 08 January 2016 07:05 AM, Krzysztof Kozlowski wrote:
> ()2016-01-07 23:38 GMT+09:00 Laxman Dewangan <ldewangan@nvidia.com>:
> +                               dev_err(dev,
> +                                   "FPS enable-input %u is not supported\n",
> +                                       pval);
> Indentation of arguments does not seem equal here or maybe this is
> just my email client. Have you run this through checkpatch? And
> sparse? And coccicheck (that one definitely not because kbuild is
> complaining)?
I ran checkpatch before I sent.

> +               chip->rmap[i] = devm_regmap_init_i2c(chip->clients[i],
> +               (const struct regmap_config *)&max77620_regmap_config[i]);
> Indentation looks weird here (or again this is my email client...).
> The cast is even weirder?!? Why casting?
There is some parameter difference for MAX77620 and MAX20024. I have 
only one structure for it and changing tun time so I have not define 
this structure as constant.
Now API needs const type structure and hence casting it.

However, I have  define different structure for MAX77620 and MAX20024 
which are const type and hence no need to explicitly casting here. This 
will be in my next patch.

+static inline int max77620_reg_update(struct device *dev, int sid,
+               unsigned int reg, unsigned int mask, unsigned int val)
+{
+       struct max77620_chip *chip = dev_get_drvdata(dev);
+
+       return regmap_update_bits(chip->rmap[sid], reg, mask, val);
+}

> I think all these shouldn't be static inlines in header. Although some
> of them are one-liners but rest are not. Let the compiler decide what
> to do with these wrappers.

If I dont make inline from header then this will complain as unused 
static function on related C compilation if it is not used on C. This 
header included from all sub module driver and they are not using all 
these APIs.

To avoid compilation warning,  I need to use inline here.


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
