Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.micronovasrl.com ([212.103.203.10]:60652 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbeGRJuu (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Jul 2018 05:50:50 -0400
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 26915B00789
        for <linux-rtc@vger.kernel.org>; Wed, 18 Jul 2018 11:13:54 +0200 (CEST)
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9Nr5we-I73Py for <linux-rtc@vger.kernel.org>;
        Wed, 18 Jul 2018 11:13:52 +0200 (CEST)
Subject: Re: [PATCH v7 3/4] rtc: ds1307: add offset sysfs for mt41txx chips.
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180718084916.79837-1-giulio.benetti@micronovasrl.com>
 <20180718084916.79837-2-giulio.benetti@micronovasrl.com>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <09456f94-8f4d-875d-c87f-4dedfeeebadc@micronovasrl.com>
Date: Wed, 18 Jul 2018 11:13:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180718084916.79837-2-giulio.benetti@micronovasrl.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Alexandre,

Il 18/07/2018 10:49, Giulio Benetti ha scritto:
> m41txx chips can hold a calibration value to get correct clock bias.
> 
> Add offset handling (ranging between -63ppm and 126ppm) via sysfs.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
> V6 => V7:
> * changed PPM to PPB as rtc sysfs offset handles PPB
>   drivers/rtc/rtc-ds1307.c | 77 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
> 
> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
> index 0162a600ff1b..b2ef9defc349 100644
> --- a/drivers/rtc/rtc-ds1307.c
> +++ b/drivers/rtc/rtc-ds1307.c
> @@ -114,6 +114,20 @@ enum ds_type {
>   #	define RX8025_BIT_VDET		0x40
>   #	define RX8025_BIT_XST		0x20
>   
> +#define M41TXX_REG_CONTROL	0x07
> +#	define M41TXX_BIT_OUT		0x80
> +#	define M41TXX_BIT_FT		0x40
> +#	define M41TXX_BIT_CALIB_SIGN	0x20
> +#	define M41TXX_M_CALIBRATION	0x1f

Sorry, I've forgot to use BIT().
I would also use GENMASK() for M41TXX_M_CALIBRATION.
I correct and resend asap.

Giulio
