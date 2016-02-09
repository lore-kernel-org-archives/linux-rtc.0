Return-Path: <rtc-linux+bncBD2OLRXW4ABBBAUG5C2QKGQEIAGOO3Y@googlegroups.com>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com. [216.228.121.64])
        by gmr-mx.google.com with ESMTPS id u66si5319003pfa.2.2016.02.09.07.17.21
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 07:17:21 -0800 (PST)
Message-ID: <56BA0049.6070500@nvidia.com>
Date: Tue, 9 Feb 2016 20:35:45 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>, Javier Martinez Canillas
	<javier@osg.samsung.com>
CC: <lee.jones@linaro.org>, <alexandre.belloni@free-electrons.com>,
	<k.kozlowski@samsung.com>, <gregkh@linuxfoundation.org>,
	<a.zummo@towertech.it>, <cw00.choi@samsung.com>,
	<linux-kernel@vger.kernel.org>, <rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH V6 1/6] regmap: irq: dispose all virtual irq
 before removing domain
References: <1455020907-4564-1-git-send-email-ldewangan@nvidia.com> <1455020907-4564-2-git-send-email-ldewangan@nvidia.com> <56B9E93A.2040903@osg.samsung.com> <20160209151421.GF13270@sirena.org.uk>
In-Reply-To: <20160209151421.GF13270@sirena.org.uk>
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


On Tuesday 09 February 2016 08:44 PM, Mark Brown wrote:
> * PGP Signed by an unknown key
>
> On Tue, Feb 09, 2016 at 10:27:22AM -0300, Javier Martinez Canillas wrote:
>
>> I believe this patch could be picked separately and not made part of
>> this series since is fixing a bug that happens on most drivers using
>> the regmap-irq API. This will avoid cross-subsystem churn for people.
> Yes, please don't mix things in when there are no dependencies.
>

Do I need to resend the patches on which 1/6 is not in series?

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
