Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.16.65.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446626;
	b=kwBwQnV3QcHx1llHg8kh1SUwTWgku8IcNMBr8oX0jv+QqE82BrR6YPPqSbM+Nf1ZjyS3
	 iImkQLOR5pNwDURsMRvi2FfGKy2hWlUfECGkro1f2gCHZA26jbdsKMbOEAeo8eQc0Cn1H
	 W9sm3R9groLnXe3ndsHz8N+y1+eq4ISqouaVy91ZJ0DRTBIuloRxzpO27+wxP1IBTAOh2
	 rMmuGPi5k7e+07Hr23l/Juoe11+Sgn2bDDzNyNjKsMkqoQfj7jEpevZRmv/+tHlDTYlT1
	 qS43zEu/5WMwN+tiV9Qulvg6SxTVY/GGN5Knsjw7vgBLULihMFvOruFw73p+P+Ro6aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446626;
	h=DMARC-Filter:Received:DKIM-Filter:To:From:X-Ip:X-Ip-source:
	 Precedence:List-Unsubscribe:List-Unsubscribe-Post:Subject:
	 Mime-Version:Content-Type:Content-Transfer-Encoding:X-MagazineId:
	 X-uId:X-Sender:X-Url:Message-Id:Date;
	bh=cKHTWepRmHhIRQC7HbBqttF3KZv6dA0iw7GtHge4jYA=;
	b=ed6Jp6kf2FCvY6F0SUwOF+7hGy2tLtn5V0QrdjuUhvFuI2t/HkbOOoWasiR7lHWnScWr
	 roU6M4AE5U2bo668GEJEONGpLZ0IBMYq1pc9jA13CvONGVZHHN0MZAeIVlzSzmMu063cJ
	 vSXlrICptw1KnMpt2m+q267ohiIneS+/FNr97WYXQKJx93/WI41flQ3T3EflGJ+XagQEu
	 613OALsmY4MZ9ILX77WfcxKYKszQOJUMQhpnX7JfSx8D9BV1mF5icJnk8KFqqxbjWc82U
	 YxjQm/J/ctW1g095qyvPsfMO00GBUf10QOxO6nVishWDvPIbp3fX/f6Z6N0/9kK6Hxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=eassist-corp.jp;
	spf=pass smtp.mailfrom=magerr.combzmail.jp;
	arc=none smtp.remote-ip=160.16.65.223
Received: from r9220.ps.combzmail.jp (r9220.ps.combzmail.jp [160.16.65.223])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60367606A324
	for <linux-rtc@vger.kernel.org>; Thu, 12 Nov 2026 01:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60367606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eassist-corp.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9220.ps.combzmail.jp (Postfix, from userid 99)
	id 1E071C12FA; Thu, 12 Nov 2026 09:59:35 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9220.ps.combzmail.jp 1E071C12FA
To: linux-rtc@vger.kernel.org
From: =?ISO-2022-JP?B?GyRCTmtMWiE/JSQhPCUiJTclOSVIGyhC?= <info@eassist-corp.jp>
X-Ip: 471529784612892
X-Ip-source: k85gj76248dnsa7uu0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCSyxMZDc/JE4lWCUiJSslQyVIO3Y2SCEhGyhC?=
 =?ISO-2022-JP?B?GyRCJSohPCVKITxKZz04GyhC?=
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: 627u
X-uId: 6764325038486067645048291018
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20261112012318.1E071C12FA@r9220.ps.combzmail.jp>
Date: Thu, 12 Nov 2026 09:59:35 +0900 (JST)

　
　4,300以上の福祉施設から、依頼が集まり続け
　既存の全国100拠点だけでは供給が追いつかない・・・。
　
　この需給ギャップを埋めるため「訪問型理美容サービス事業」の
　フランチャイズ加盟店・オーナー様を新たに募集しております。

　<説明会の日程>
　11月12日（木）13:00-14:00
　11月17日（火）13:00-14:00
　
　<オンライン視聴はこちら>
　https://eassist-corp.work/beauty3/
　
　
◆…─…─…─…─…─…─…─…─…─…─…─…─…─…─…─…─…─◇
　
　いわゆる“2025年問題”を背景に、
　訪問理美容へのニーズは年々高まり、メディアからも注目が集まっています。
　
　堀江貴文さんのYouTubeチャンネル（ホリエモンチャンネル）でも
　本事業が取り上げられ、大きな反響を呼んでいます。
　
　（動画リンク）
　https://www.youtube.com/watch?v=FpCmymNWXcw

◆…─…─…─…─…─…─…─…─…─…─…─…─…─…─…─…─…─◇
　
　
　いつもお世話になっております。
　イーアシスト セミナー事務局です。
　
　この度、全国で急拡大を続ける「訪問型理美容サービス」の
　フランチャイズ説明会をご案内いたします。

　
　訪問型理美容サービスとは？

　高齢・疾病・ケガ・障がいなどにより、外出が難しい方の
　ご自宅や介護施設を訪問し、
　カットを中心とした理美容サービスを提供する事業です。
　
　すでに 4,300以上の福祉施設と提携しており、
　安定した需要に支えられた成長マーケットです。
　
　現在は、全国100拠点超で対応していますが、

　施設側からの依頼増加に対して供給が追いつかず、
　新店の開設が急務となっています。


　この事業を開業するにあたって、
　オーナー様に理美容等の専門資格は不要です。
　
　本部が理美容師の採用を全面サポートいたしますので、
　オーナー様は マネジメントと事業運営に専念いただけます。


　さらに、開業後の軌道化を後押しする仕組みとして、
　　「既存の提携施設の案件をご紹介」
　　「本部が新規で提携施設の営業を実施」

　新規開拓の支援を本部側で行います。
　
　
　■セミナー内
──────────────────────────────
　・初期投資の内訳
　・モデル収支と回収期間
　・施設紹介制度を含むサポート体制
　・事業の将来性と市場データ
　・成功オーナーの取組み事例　など
　

　事業としての安定性・社会貢献性・スケール性を
　総合的に判断いただける内容となっております。

　　＞＞ オンライン視聴はこちら ＜＜
　　https://eassist-corp.work/beauty3/


***********************************************************************
メールでのご連絡、大変失礼しました。
こちらのメールが不要な方は、お手数ですが下記よりお手続きをお願いします。
https://eassist-corp.work/mail/

***********************************************************************
イーアシスト　セミナー運営事務局
大阪市中央区日本橋1-17-17-604
TEL：06-6253-0875
***********************************************************************
