Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:54895 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932176AbdJJNcA (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 10 Oct 2017 09:32:00 -0400
MIME-Version: 1.0
In-Reply-To: <1507578100-2148-1-git-send-email-eric@nelint.com>
References: <1507578100-2148-1-git-send-email-eric@nelint.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 10 Oct 2017 10:31:59 -0300
Message-ID: <CAOMZO5C_boginn88C7zgXSBaikx==5FHJrgaE1ewYUyUgGfnFQ@mail.gmail.com>
Subject: Re: [PATCH] rtc: add support for NXP PCF85363 real-time clock
To: Eric Nelson <eric@nelint.com>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Otavio Salvador <otavio.salvador@ossystems.com.br>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Eric,

On Mon, Oct 9, 2017 at 4:41 PM, Eric Nelson <eric@nelint.com> wrote:

> +config RTC_DRV_PCF85363
> +       tristate "NXP PCF85363"
> +       depends on I2C

It seems you missed a dependency on REGMAP_I2C.

> +static const struct i2c_device_id pcf85363_id[] = {
> +       { "pcf85363", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, pcf85363_id);

Even though the driver can probe via the i2c device id, it is
recommended to explicitly pass the compatible string:

static const struct of_device_id pcf85363_dt_match[] = {
{ .compatible = "nxp,pcf85363" },
{ },

See this previous discussion:
https://www.spinics.net/lists/devicetree/msg195176.html
