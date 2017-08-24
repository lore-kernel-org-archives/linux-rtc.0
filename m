Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:32959 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753215AbdHXOQN (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 24 Aug 2017 10:16:13 -0400
MIME-Version: 1.0
In-Reply-To: <20170823220024.22861-1-alexandre.belloni@free-electrons.com>
References: <20170823220024.22861-1-alexandre.belloni@free-electrons.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 24 Aug 2017 11:16:11 -0300
Message-ID: <CAOMZO5B2MxGt8DnXU8v1DG9LdbvxyN0FFDJm=dTO=18i=1r4mA@mail.gmail.com>
Subject: Re: [PATCH] rtc: mxc: avoid disabling interrupts on device close
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Aug 23, 2017 at 7:00 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Currently, the IRQs are disabled when the rtc character device is closed.
> This means that the device needs to stay open to get alarms while the usual
> use case will open the device, set the alarm and close the device as is
> done in rtcwake.
>
> Keep the alarm functional on character device release so the platform can
> actually wakeup
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Makes sense, thanks:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
