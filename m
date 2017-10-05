Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:48928 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbdJEW1r (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 5 Oct 2017 18:27:47 -0400
Date: Thu, 5 Oct 2017 17:27:45 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/6] dt-bindings: rtc: document existing bindings
Message-ID: <20171005222745.ppbilw3jle67ixsa@rob-hp-laptop>
References: <20170927140345.5537-1-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170927140345.5537-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Wed, Sep 27, 2017 at 04:03:39PM +0200, Alexandre Belloni wrote:
> Document currently undocumented bindings.
> 
> Rob, as discussed, all of this can probably go through your tree.
> 
> Changes in v2:
>  - made a proper series
>  - fixed sirf2 example
>  - listed the ds1307 compatible that support the trickle charging properties
> 
> Alexandre Belloni (6):
>   dt-bindings: trivial: Add RTCs
>   dt-bindings: rtc: add stericsson,coh901331 bindings
>   dt-bindings: rtc: Add sirf,prima2-sysrtc bindings
>   dt-bindings: rtc: DS1307 and compatibles are not trivial
>   dt-bindings: rtc: Add bindings for m41t80 and compatibles
>   dt-bindings: rtc: merge ds1339 in ds1307 documentation

Series applied.

Rob
