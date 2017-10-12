Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:49522 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756600AbdJLVzg (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 12 Oct 2017 17:55:36 -0400
MIME-Version: 1.0
In-Reply-To: <1507737390-27818-1-git-send-email-eric@nelint.com>
References: <CAOMZO5C_boginn88C7zgXSBaikx==5FHJrgaE1ewYUyUgGfnFQ@mail.gmail.com>
 <1507737390-27818-1-git-send-email-eric@nelint.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 12 Oct 2017 18:55:35 -0300
Message-ID: <CAOMZO5DDy9xEpJ9bn1F+0668PRAmp_n5ZweB=7EXtQQRd2=eMA@mail.gmail.com>
Subject: Re: [PATCH V2] rtc: add support for NXP PCF85363 real-time clock
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

On Wed, Oct 11, 2017 at 12:56 PM, Eric Nelson <eric@nelint.com> wrote:
> Note that alarms are not currently implemented.
>
> 64 bytes of nvmem is supported and exposed in
> sysfs (# is the instance number, starting with 0):
>
>         /sys/bus/nvmem/devices/pcf85363-#/nvmem
>
> Signed-off-by: Eric Nelson <eric@nelint.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
