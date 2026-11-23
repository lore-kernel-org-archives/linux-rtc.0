Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456947;
	b=L45fNkANkxGKazVcEc6ZwVVx4xHCIfYZWgdlthE5uPFJMeo3t5K1TgsbQox8OOnUqDrh
	 tums7JOF8h8bfQjfPamMXqxPo9EjC3pwRQMK9Xfu4lI2o/dUoS1d1oab1qWVOSNeD1XqX
	 87twGCvNeuHOUsAe3iqhxzmispJO91acdVS1mgEIfKWAlPTlb6nzQot5QQbROOGD511nT
	 hmjBmWKxyYe//xHQ3uc74VP7AzEAsJ4+ronHJqDpgJmpTJX36C69fQXG4zSlCV9kwWo0x
	 8s4Z/o3OirG4EdqL14CVldTNLStqj5RiQmGXzfRCrxUyaYqL+NkcQ5eY8IXmgDVr7SQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456947;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vDttuoLtThpmrLHDgUDrvKFHZsebodC8mQspl8DHMwU=;
	b=ac8hCdvEEsbH1LAA9ayxkBsSiU4LvkS+3le7eUfN7CooKpCc8EmGyZcHJYI/5o4Dh/HC
	 lHWw1b2dbgMiERXmo31ooDu0oKfwrQ5HeEGMd3BuU3jKXYWpa+oKASb48/s3SqyRo08pD
	 Ih0/YUJ885RwQsFBzOJ/BhkMT7FpdGorSIj2ixMHgNqXw5NRc8SHVt8BKRBlHrQsbdS02
	 HTNL0T6kKMJRCuNlYugvPS04PS0vSVzy5gDPBigiQl+qq69ufwKOBMSeJ5993qaZh937Y
	 UgvBkJt6K9DGnk8sGII79ZX0OoeH3731Nwtd4C/KvAuoKUjK4ffOnROqufzVezhT5nQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=Kxg01mX9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.15
Received: from sender-op-o15.zoho.eu (sender-op-o15.zoho.eu [136.143.169.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78751606A31A;
	Mon, 23 Nov 2026 18:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78751606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=Kxg01mX9
ARC-Seal: i=1; a=rsa-sha256; t=1795456903; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=PaEyfUHI9/dg2Kik0zoccRrZZeS8oCPNzXKct42xtmbfG1sZf7ENSKszKndKxPpppPLUn9jqDFg1bMH9/oECr2KyOwTObfomSzwWZ4D5sH4318qx8fIWKN8RE6fUo3iDG/W6c4hO46lmxUvgx7NbZQXR3hLJoih8q84cPvfK5Bs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1795456903; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vDttuoLtThpmrLHDgUDrvKFHZsebodC8mQspl8DHMwU=; 
	b=T6Q6yKHs69OGVVqU6pq4IQfdJlyAI81yHIBcuFVGB2FzftKh4QkUVkdHQ9z4phc4x2tAABLy+883RnzDGlWi+dHJVMF5gMplguY1xktpz/223/o/HcTEMlRKZz/HokdeKhuptkMZMTPVlxpBUx+gP5LKkpve/z0R/NYEFHO/LS8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=Kxg01mX9YeAZiV9Qs1JStftSmBv4b9pv3eCwsQZnx6ouWvP6EME1GmujpM84Ok9QbXQ4jTAhqMNTzGJngNoNRimp5oO8GLtL6PioAdtuBLELn2YMO8nFZJCN4ca5kRomt+2K+qdlqw757oHQWVVWso1aOQ2ekav8bMiNO4CGiLY=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=vDttuoLtThpmrLHDgUDrvKFHZsebodC8mQspl8DHMwU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1795456902105430.43361214454706;
	Mon, 23 Nov 2026 19:01:42 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] dt-bindings: rtc: Add linux,wakeup-states
Date: Mon, 23 Nov 2026 20:01:12 +0200
Message-ID: <20261123-alarmtimer-rtc-priority-v2-krzk-reply-1@iav.lv>
In-Reply-To: <20261123-literate-significant-wildcat-dcfffa@quoll>
References: <20261116-b4-alarmtimer-rtc-priority-v2-0-b2c69721e489@iav.lv>
 <20261116-b4-alarmtimer-rtc-priority-v2-6-b2c69721e489@iav.lv>
 <20261123-literate-significant-wildcat-dcfffa@quoll>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Nov 23, 2026 at 11:48:11AM +0100, Krzysztof Kozlowski wrote:
> This looks exactly like re-implementing system-idle-states.yaml and wakeup-source.

Right, thanks. v3 will use wakeup-source with phandles to
system-idle-states.

Two questions before I rework it:
- alarmtimer needs a suspend state for each phandle. Is mapping
  standby to s2idle and shallow, and the mem* states to deep, acceptable?
- linux,wakeup-states = "none" covered an RTC that wakes the system from
  no state, e.g. meson-vrtc, which enables wakeup unconditionally, on a
  board whose firmware ignores it. How should a board describe that
  with wakeup-source?

--
Igor Velkov
