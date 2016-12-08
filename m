Return-Path: <rtc-linux+bncBAABBUGDU3BAKGQEEYPIZTQ@googlegroups.com>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk. [2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by gmr-mx.google.com with ESMTPS id d199si1491879wmd.1.2016.12.08.10.09.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Dec 2016 10:09:20 -0800 (PST)
Date: Thu, 8 Dec 2016 18:09:08 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	rtc-linux@googlegroups.com,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [rtc-linux] Re: [PATCH 3/3] rtc: armada38x: Prepare for being use on
 64 bits
Message-ID: <20161208180908.GL14217@n2100.armlinux.org.uk>
References: <20161208171010.29446-1-gregory.clement@free-electrons.com>
 <20161208171010.29446-4-gregory.clement@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20161208171010.29446-4-gregory.clement@free-electrons.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Dec 08, 2016 at 06:10:10PM +0100, Gregory CLEMENT wrote:
> The drivers are supposed to be portable, however there are few assumption
> done here about the unsigned long size. Make sure we use the accurate
> width for the variable.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/rtc/rtc-armada38x.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
> index b8a74ffaae80..c4138130febf 100644
> --- a/drivers/rtc/rtc-armada38x.c
> +++ b/drivers/rtc/rtc-armada38x.c
> @@ -84,14 +84,14 @@ static void rtc_update_mbus_timing_params(struct armada38x_rtc *rtc)
>  }
>  
>  struct str_value_to_freq {
> -	unsigned long value;
> +	u32 value;
>  	u8 freq;
>  } __packed;
>  
> -static unsigned long read_rtc_register_wa(struct armada38x_rtc *rtc, u8 rtc_reg)
> +static u32 read_rtc_register_wa(struct armada38x_rtc *rtc, u8 rtc_reg)
>  {
> -	unsigned long value_array[SAMPLE_NR], i, j, value;
> -	unsigned long max = 0, index_max = SAMPLE_NR - 1;
> +	int i, j, index_max = SAMPLE_NR - 1;
> +	u32 value_array[SAMPLE_NR], value, max = 0;

Ah, I see my comments on patch 1 got addressed in patch 3... :)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
