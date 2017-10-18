Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:45195 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753871AbdJRNcO (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Oct 2017 09:32:14 -0400
Message-ID: <1508333529.13340.26.camel@mtksdaap41>
Subject: Re: [PATCH v2 1/4] dt-bindings: rtc: mediatek: add bindings for
 MediaTek SoC based RTC
From: Yingjoe Chen <yingjoe.chen@mediatek.com>
To: <sean.wang@mediatek.com>
CC: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date: Wed, 18 Oct 2017 21:32:09 +0800
In-Reply-To: <235e4bdaa605021facf4ab5c4e8a2ecc5293516d.1508231935.git.sean.wang@mediatek.com>
References: <cover.1508231935.git.sean.wang@mediatek.com>
         <235e4bdaa605021facf4ab5c4e8a2ecc5293516d.1508231935.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, 2017-10-17 at 17:40 +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add device-tree binding for MediaTek SoC based RTC
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/rtc/rtc-mediatek.txt        | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mediatek.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-mediatek.txt b/Documentation/devicetree/bindings/rtc/rtc-mediatek.txt
> new file mode 100644
> index 0000000..09fe8f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-mediatek.txt


How about change this filename to match driver filename change?

Joe.C
