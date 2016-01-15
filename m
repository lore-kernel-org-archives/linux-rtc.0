Return-Path: <rtc-linux+bncBDJIP47K7MERBFV74G2AKGQEP6O5HTQ@googlegroups.com>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTP id 190si1043233pfb.1.2016.01.14.18.55.17
        for <rtc-linux@googlegroups.com>;
        Thu, 14 Jan 2016 18:55:17 -0800 (PST)
Date: Thu, 14 Jan 2016 20:55:13 -0600
From: Rob Herring <robh@kernel.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
	lee.jones@linaro.org, broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, lgirdwood@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, rtc-linux@googlegroups.com,
	swarren@nvidia.com, treding@nvidia.com, k.kozlowski@samsung.com
Subject: [rtc-linux] Re: [PATCH V3 1/5] DT: mfd: add device-tree binding doc
 fro PMIC max77620/max20024
Message-ID: <20160115025513.GA14066@rob-hp-laptop>
References: <1452771166-13694-1-git-send-email-ldewangan@nvidia.com>
 <1452771166-13694-2-git-send-email-ldewangan@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1452771166-13694-2-git-send-email-ldewangan@nvidia.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Jan 14, 2016 at 05:02:42PM +0530, Laxman Dewangan wrote:
> The MAXIM PMIC MAX77620 and MAX20024 are power management IC
> which supports RTC, GPIO, DCDC/LDO regulators, interrupt,
> watchdog etc.
> 
> Add DT binding document for the different functionality of
> this device.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
> Changes from V1: 
> - Added units in some of properties.
> - Change the boolean property to tristate type and detail some of
>   properties.
> 
> Change from V2:
> - added unit in period related dt property.
> 
>  Documentation/devicetree/bindings/mfd/max77620.txt | 397 +++++++++++++++++++++
>  include/dt-bindings/mfd/max77620.h                 |  38 ++
>  2 files changed, 435 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max77620.txt
>  create mode 100644 include/dt-bindings/mfd/max77620.h

Acked-by: Rob Herring <robh@kernel.org>

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
