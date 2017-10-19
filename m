Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:9884 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751479AbdJSDA0 (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 18 Oct 2017 23:00:26 -0400
Message-ID: <1508382018.21840.124.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/4] dt-bindings: rtc: mediatek: add bindings for
 MediaTek SoC based RTC
From: Sean Wang <sean.wang@mediatek.com>
To: Yingjoe Chen <yingjoe.chen@mediatek.com>
CC: <a.zummo@towertech.it>, <alexandre.belloni@free-electrons.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date: Thu, 19 Oct 2017 11:00:18 +0800
In-Reply-To: <1508333529.13340.26.camel@mtksdaap41>
References: <cover.1508231935.git.sean.wang@mediatek.com>
         <235e4bdaa605021facf4ab5c4e8a2ecc5293516d.1508231935.git.sean.wang@mediatek.com>
         <1508333529.13340.26.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, 2017-10-18 at 21:32 +0800, Yingjoe Chen wrote:
> On Tue, 2017-10-17 at 17:40 +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Add device-tree binding for MediaTek SoC based RTC
> > 
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/rtc/rtc-mediatek.txt        | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mediatek.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/rtc-mediatek.txt b/Documentation/devicetree/bindings/rtc/rtc-mediatek.txt
> > new file mode 100644
> > index 0000000..09fe8f5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/rtc-mediatek.txt
> 
> 
> How about change this filename to match driver filename change?
> 
> Joe.C
> 

Will be improved together with the other patches
