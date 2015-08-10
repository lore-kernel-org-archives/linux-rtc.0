Return-Path: <rtc-linux+bncBD66BCOYSQBBBWG5UGXAKGQE64WBZLI@googlegroups.com>
Received: from devils.ext.ti.com (devils.ext.ti.com. [198.47.26.153])
        by gmr-mx.google.com with ESMTPS id 4si390005igl.1.2015.08.10.02.28.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 02:28:55 -0700 (PDT)
From: Keerthy <j-keerthy@ti.com>
To: <tony@atomide.com>, <linux-omap@vger.kernel.org>, <pawel.moll@arm.com>
CC: <galak@codeaurora.org>, <paul@pwsan.com>,
        <alexandre.belloni@free-electrons.com>, <akpm@linux-foundation.org>,
        <johan@kernel.org>, <grygorii.strashko@ti.com>,
        <rtc-linux@googlegroups.com>, <bcousson@baylibre.com>, <nm@ti.com>,
        <devicetree@vger.kernel.org>, <t-kristo@ti.com>, <j-keerthy@ti.com>
Subject: [rtc-linux] [PATCH v2 3/6] ARM: AM43xx: Introduce a separate soc_is
 function for am438x series of SoCs
Date: Mon, 10 Aug 2015 14:58:23 +0530
Message-ID: <1439198906-31189-4-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

EPOS evms are fitted with a separate family of am43xx SoCs and are named
am438x series. Adding a separate soc_is function to identify that
particular series of SoCs. This can be done to avoid unnecessarily
registering hwmods like rtc when not needed on EPOS evms.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/omap.txt | 3 +++
 arch/arm/mach-omap2/board-generic.c                 | 1 +
 arch/arm/mach-omap2/id.c                            | 2 ++
 arch/arm/mach-omap2/soc.h                           | 7 +++++--
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 9f4e513..4269c13 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -100,6 +100,9 @@ SoCs:
 - AM4372
   compatible = "ti,am4372", "ti,am43"
 
+- AM438x
+  compatible = "ti,am438x", "ti,am43"
+
 Boards:
 
 - OMAP3 BeagleBoard : Low cost community board
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 34ff14b..3d70d6a 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -266,6 +266,7 @@ MACHINE_END
 #ifdef CONFIG_SOC_AM43XX
 static const char *const am43_boards_compat[] __initconst = {
 	"ti,am4372",
+	"ti,am438x",
 	"ti,am43",
 	NULL,
 };
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index e3f713f..1bab9f5 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -228,6 +228,8 @@ static void __init omap3_cpuinfo(void)
 		cpu_name =  "AM335X";
 	} else if (soc_is_am437x()) {
 		cpu_name =  "AM437x";
+	} else if (soc_is_am438x()) {
+		cpu_name =  "AM438X";
 	} else if (cpu_is_ti814x()) {
 		cpu_name = "TI814X";
 	} else if (omap3_has_iva() && omap3_has_sgx()) {
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index f97654d..feb27fd 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -238,6 +238,7 @@ IS_AM_SUBCLASS(437x, 0x437)
 #define soc_is_am335x()			0
 #define soc_is_am43xx()			0
 #define soc_is_am437x()			0
+#define soc_is_am438x()			0
 #define cpu_is_omap44xx()		0
 #define cpu_is_omap443x()		0
 #define cpu_is_omap446x()		0
@@ -371,8 +372,10 @@ IS_OMAP_TYPE(3430, 0x3430)
 #ifdef	CONFIG_SOC_AM43XX
 # undef soc_is_am43xx
 # undef soc_is_am437x
-# define soc_is_am43xx()		is_am43xx()
-# define soc_is_am437x()		is_am437x()
+# undef soc_is_am438x
+# define soc_is_am43xx()		of_machine_is_compatible("ti,am43")
+# define soc_is_am437x()		of_machine_is_compatible("ti,am4372")
+# define soc_is_am438x()		of_machine_is_compatible("ti,am438x")
 #endif
 
 # if defined(CONFIG_ARCH_OMAP4)
-- 
1.9.1

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
