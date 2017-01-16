Return-Path: <rtc-linux+bncBDZK35H6VQBRBMFV6PBQKGQE2OCTKVY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com. [62.209.51.94])
        by gmr-mx.google.com with ESMTPS id d130si743610wmf.0.2017.01.16.06.37.35
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jan 2017 06:37:35 -0800 (PST)
Subject: [rtc-linux] Re: [PATCHv3 8/8] ARM: configs: stm32: Add RTC support in
 STM32 defconfig
To: Amelie Delaunay <amelie.delaunay@st.com>,
        Alessandro Zummo
	<a.zummo@towertech.it>,
        Alexandre Belloni
	<alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>
References: <1483623809-29937-1-git-send-email-amelie.delaunay@st.com>
 <1483623809-29937-9-git-send-email-amelie.delaunay@st.com>
CC: <rtc-linux@googlegroups.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <0e58dc4b-e7d7-e327-6f8d-35253216a496@st.com>
Date: Mon, 16 Jan 2017 15:37:09 +0100
MIME-Version: 1.0
In-Reply-To: <1483623809-29937-9-git-send-email-amelie.delaunay@st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Am=C3=A9lie,

On 01/05/2017 02:43 PM, Amelie Delaunay wrote:
> This patch adds STM32 RTC support in stm32_defconfig file.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  arch/arm/configs/stm32_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_de=
fconfig
> index be19e09..0acff9e 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -57,6 +57,8 @@ CONFIG_LEDS_CLASS=3Dy
>  CONFIG_LEDS_GPIO=3Dy
>  CONFIG_LEDS_TRIGGERS=3Dy
>  CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
> +CONFIG_RTC_CLASS=3Dy
> +CONFIG_RTC_DRV_STM32=3Dy
>  CONFIG_DMADEVICES=3Dy
>  CONFIG_STM32_DMA=3Dy
>  # CONFIG_FILE_LOCKING is not set
>
Applied on stm32-defconfig-for-v4.11

thanks
Alex

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
