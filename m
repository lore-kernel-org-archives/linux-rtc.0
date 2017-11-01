Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754687AbdKARpz (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 1 Nov 2017 13:45:55 -0400
MIME-Version: 1.0
In-Reply-To: <1509548480-29472-1-git-send-email-eric@nelint.com>
References: <CAL_Jsq+QQK=NTMBwk=h0uszLW0uSiEd1fmF09USRNFM-2VgiSQ@mail.gmail.com>
 <1509548480-29472-1-git-send-email-eric@nelint.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 1 Nov 2017 12:45:33 -0500
Message-ID: <CAL_JsqK6inxGGWtV3hU6Y1HFMfx9szpF=OCfvE2hCZDkerOMVA@mail.gmail.com>
Subject: Re: [PATCH V3] rtc: add support for NXP PCF85363 real-time clock
To: Eric Nelson <eric@nelint.com>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Otavio Salvador <otavio.salvador@ossystems.com.br>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Nov 1, 2017 at 10:01 AM, Eric Nelson <eric@nelint.com> wrote:
> Note that alarms are not currently implemented.
>
> 64 bytes of nvmem is supported and exposed in
> sysfs (# is the instance number, starting with 0):
>
>         /sys/bus/nvmem/devices/pcf85363-#/nvmem
>
> Signed-off-by: Eric Nelson <eric@nelint.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> V2 addresses a couple of issues highlighted by Fabio Estevam
>     1. Kconfig updated to select REGMAP_I2C
>     2. Switch to of_device_id from i2c_device_id for driver matching
>
> V3 adds interrupts as an optional property in device tree bindings
>
>  drivers/rtc/Kconfig                                |  13 ++
>  drivers/rtc/Makefile                               |   1 +
>  drivers/rtc/rtc-pcf85363.c                         | 221 +++++++++++++++++++++
>  4 files changed, 252 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/pcf85363.txt
>  create mode 100644 drivers/rtc/rtc-pcf85363.c

For the binding:

Acked-by: Rob Herring <robh@kernel.org>
