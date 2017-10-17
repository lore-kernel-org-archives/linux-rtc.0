Return-Path: <rtc-linux+bncBDIOBYPK6QDRBTPYS7HQKGQE7Q2HJKA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-out.m-online.net (mail-out.m-online.net. [2001:a60:0:28:0:1:25:1])
        by gmr-mx.google.com with ESMTPS id w14si466155lfk.2.2017.10.17.05.49.16
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Oct 2017 05:49:16 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH] rtc: ds1307: add OF and ACPI entries for
 Epson RX8130
To: Bastian Stender <bst@pengutronix.de>, rtc-linux@googlegroups.com
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Arnd Bergmann <arnd@arndb.de>, Felipe Balbi <balbi@ti.com>,
 Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>,
 kernel@pengutronix.de
References: <20171017124607.17461-1-bst@pengutronix.de>
From: Marek Vasut <marex@denx.de>
Message-ID: <6c4c6718-fda0-80df-d217-da27108f4809@denx.de>
Date: Tue, 17 Oct 2017 14:49:14 +0200
MIME-Version: 1.0
In-Reply-To: <20171017124607.17461-1-bst@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 10/17/2017 02:46 PM, Bastian Stender wrote:
> Make Epson RX8130 device tree and ACPI aware.
> 
> Fixes: ee0981be7704 ("rtc: ds1307: Add support for Epson RX8130CE")

Fixes , really ? I don't think it's broken in any way without the ACPI
entries.

> Signed-off-by: Bastian Stender <bst@pengutronix.de>
> ---
>  drivers/rtc/rtc-ds1307.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index e7d9215c9201..8e2cd45a2f96 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -325,6 +325,10 @@ static const struct of_device_id ds1307_of_match[] = {
>  		.compatible = "isil,isl12057",
>  		.data = (void *)ds_1337
>  	},
> +	{
> +		.compatible = "epson,rx8130",
> +		.data = (void *)rx_8130
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ds1307_of_match);
> @@ -348,6 +352,7 @@ static const struct acpi_device_id ds1307_acpi_ids[] = {
>  	{ .id = "PT7C4338", .driver_data = ds_1307 },
>  	{ .id = "RX8025", .driver_data = rx_8025 },
>  	{ .id = "ISL12057", .driver_data = ds_1337 },
> +	{ .id = "RX8130", .driver_data = rx_8130 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, ds1307_acpi_ids);
> 


-- 
Best regards,
Marek Vasut

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
