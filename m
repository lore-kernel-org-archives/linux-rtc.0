Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx2.rt-rk.com ([89.216.37.149]:50909 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751685AbdF1P7R (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Wed, 28 Jun 2017 11:59:17 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: linux-mips@linux-mips.org
Cc: Aleksandar Markovic <aleksandar.markovic@imgtec.com>,
        Miodrag Dinic <miodrag.dinic@imgtec.com>,
        Goran Ferenc <goran.ferenc@imgtec.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Douglas Leung <douglas.leung@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Petar Jovanovic <petar.jovanovic@imgtec.com>,
        Raghu Gandham <raghu.gandham@imgtec.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 01/10] Documentation: Add device tree binding for Goldfish RTC driver
Date: Wed, 28 Jun 2017 17:46:54 +0200
Message-Id: <1498664922-28493-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1498664922-28493-1-git-send-email-aleksandar.markovic@rt-rk.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

From: Aleksandar Markovic <aleksandar.markovic@imgtec.com>

Add documentation for DT binding of Goldfish RTC driver. The compatible
string used by OS for binding the driver is "google,goldfish-rtc".

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtec.com>
---
 .../devicetree/bindings/rtc/google,goldfish-rtc.txt     | 17 +++++++++++++++++
 MAINTAINERS                                             |  5 +++++
 2 files changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt b/Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
new file mode 100644
index 0000000..634312d
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
@@ -0,0 +1,17 @@
+Android Goldfish RTC
+
+Android Goldfish RTC device used by Android emulator.
+
+Required properties:
+
+- compatible : should contain "google,goldfish-rtc"
+- reg        : <registers mapping>
+- interrupts : <interrupt mapping>
+
+Example:
+
+	goldfish_timer@9020000 {
+		compatible = "google,goldfish-rtc";
+		reg = <0x9020000 0x1000>;
+		interrupts = <0x3>;
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 09b5ab6..519cdef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -841,6 +841,11 @@ S:	Supported
 F:	drivers/android/
 F:	drivers/staging/android/
 
+ANDROID GOLDFISH RTC DRIVER
+M:	Miodrag Dinic <miodrag.dinic@imgtec.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
+
 ANDROID ION DRIVER
 M:	Laura Abbott <labbott@redhat.com>
 M:	Sumit Semwal <sumit.semwal@linaro.org>
-- 
2.7.4
