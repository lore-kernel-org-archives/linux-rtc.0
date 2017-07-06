Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBXOG7LFAKGQEHTCZCPA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id m89si277366wmi.0.2017.07.06.13.53.49
        for <rtc-linux@googlegroups.com>;
        Thu, 06 Jul 2017 13:53:49 -0700 (PDT)
Date: Thu, 6 Jul 2017 22:53:38 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCHv2 0/2] rtc: add support for STM32H7 RTC
Message-ID: <20170706205338.oke7vnr7nh5s6ykq@piout.net>
References: <1499330865-17232-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <1499330865-17232-1-git-send-email-amelie.delaunay@st.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 06/07/2017 at 10:47:43 +0200, Amelie Delaunay wrote:
> Add support for STM32H7 Real Time Clock variant.
> Difference is regarding clocks: there is a 'pclk' clock on STM32H7
> for register access.
> 
> Amelie Delaunay (2):
>   dt-bindings: rtc: stm32: add support for STM32H7
>   rtc: stm32: add STM32H7 RTC support
> 
>  .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 32 +++++++--
>  drivers/rtc/rtc-stm32.c                            | 82 +++++++++++++++++-----
>  2 files changed, 92 insertions(+), 22 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
