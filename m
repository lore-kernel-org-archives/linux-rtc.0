Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f169.google.com ([74.125.82.169]:38836 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752736AbeCXUAD (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sat, 24 Mar 2018 16:00:03 -0400
MIME-Version: 1.0
In-Reply-To: <53afbe8172fb1afd809ce9ba1afeda924b9ea705.1521794177.git.sean.wang@mediatek.com>
References: <cover.1521794176.git.sean.wang@mediatek.com> <53afbe8172fb1afd809ce9ba1afeda924b9ea705.1521794177.git.sean.wang@mediatek.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 24 Mar 2018 17:00:02 -0300
Message-ID: <CAOMZO5DuVpcCrQYzoWfN=ZqXeTGC-U1FfwoDFxhQ8frno5-1GQ@mail.gmail.com>
Subject: Re: [PATCH v1 11/16] rtc: mediatek: move the declaration into a
 globally visible header file
To: sean.wang@mediatek.com
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        eddie.huang@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Fri, Mar 23, 2018 at 6:15 AM,  <sean.wang@mediatek.com> wrote:

> --- /dev/null
> +++ b/include/linux/rtc/mt6397.h
> @@ -0,0 +1,72 @@
> +
> +// SPDX-License-Identifier: GPL-2.0

According to Documentation/process/license-rules.rst the SPDX notation
for C header file should be:

/* SPDX-License-Identifier: GPL-2.0 */
