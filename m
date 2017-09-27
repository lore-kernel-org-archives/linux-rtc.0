Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38043 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753057AbdI0ODt (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 27 Sep 2017 10:03:49 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 0/6] dt-bindings: rtc: document existing bindings
Date: Wed, 27 Sep 2017 16:03:39 +0200
Message-Id: <20170927140345.5537-1-alexandre.belloni@free-electrons.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Document currently undocumented bindings.

Rob, as discussed, all of this can probably go through your tree.

Changes in v2:
 - made a proper series
 - fixed sirf2 example
 - listed the ds1307 compatible that support the trickle charging properties

Alexandre Belloni (6):
  dt-bindings: trivial: Add RTCs
  dt-bindings: rtc: add stericsson,coh901331 bindings
  dt-bindings: rtc: Add sirf,prima2-sysrtc bindings
  dt-bindings: rtc: DS1307 and compatibles are not trivial
  dt-bindings: rtc: Add bindings for m41t80 and compatibles
  dt-bindings: rtc: merge ds1339 in ds1307 documentation

 .../devicetree/bindings/rtc/dallas,ds1339.txt      | 18 ---------
 .../devicetree/bindings/rtc/rtc-ds1307.txt         | 44 ++++++++++++++++++++++
 .../devicetree/bindings/rtc/rtc-m41t80.txt         | 31 +++++++++++++++
 .../devicetree/bindings/rtc/sirf,prima2-sysrtc.txt | 13 +++++++
 .../bindings/rtc/stericsson,coh901331.txt          | 17 +++++++++
 .../devicetree/bindings/trivial-devices.txt        | 13 +++----
 6 files changed, 110 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/dallas,ds1339.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-ds1307.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-m41t80.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/sirf,prima2-sysrtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/stericsson,coh901331.txt

-- 
2.14.2
